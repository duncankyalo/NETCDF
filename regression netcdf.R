# Install and load the ncdf4 package (if not already installed)
library(ncdf4)

# Replace 'path/to/your_file.nc' with the actual file path
nc_file <- nc_open("E:/R/QC_sonde_training_data.nc")

# Print information about the file
print(nc_file)

# Access data from a variable (replace 'variable_name' with the actual variable name)
data <- ncvar_get(nc_file, "pressure")

# Install and load necessary packages
install.packages(c("ncdf4", "dplyr", "ggplot2", "mgcv"))
library(ncdf4)
library(dplyr)
library(ggplot2)
library(mgcv)

# Assuming you have downloaded the NetCDF file as "dagoretti_radiosonde.nc"
nc_file <- nc_open("E:/R/QC_sonde_training_data.nc")

# Extract relevant variables
launch_time <- ncvar_get(nc_file, "launchtime")
pressure <- ncvar_get(nc_file, "pressure")
temperature <- ncvar_get(nc_file, "temperature")
humidity <- ncvar_get(nc_file, "humidity")
wind_speed <- ncvar_get(nc_file, "wind_speed")
# ... (extract other variables as needed)

# Create a data frame
# Install and load tidyr (if not already installed)
install.packages("tidyr")
library(tidyr)

##### Reshape data into long format
data_long <- data %>%
  pivot_longer(cols = -launch_time, names_to = "variable", values_to = "value")
# Data pre-processing (if needed)

# Data frame for launch times
launch_data <- data.frame(launch_time)

#### Data frame for meteorological variables(missing pressure)
meteo_data <- data.frame(temperature, humidity, wind_speed)

# Analyze each data frame separately using appropriate techniques

# Handle missing values (e.g., using na.omit() or imputation techniques)
data <- na.omit(data)

# Feature engineering (if necessary)

# Create new variables or transformations

# Regression Analysis

# Multiple Linear Regression(replace humidity with rain and after wind speed + humidity)
model <- lm(humidity ~ temperature  , data = meteo_data)
summary(model)

# Analyze coefficients to understand variable impact

# Polynomial Regression (example with temperature)
model_poly <- lm(humidity ~ poly(temperature, 2), data =meteo_data )
summary(model_poly)

# Generalized Additive Models (GAMs)
model_gam <- gam(rainfall ~ s(temperature) + s(wind_speed) + s(humidity) + s(pressure), data = data)
summary(model_gam)
plot(model_gam)

# Correlation Analysis

# Calculate correlation matrix
cor_matrix <- cor(data)
print(cor_matrix)

# Visualize correlations with ggplot2
ggplot(data, aes(x = temperature, y = rainfall)) +
  geom_point() +
  labs(title = "Scatterplot of Rainfall vs. Temperature")

# You can create similar plots for other variable pairs or use heatmaps to visualize the entire correlation matrix.

# Close the file
nc_close(nc_file)