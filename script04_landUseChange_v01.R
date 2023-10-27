########################################################################################################
# Install and load libraries
install.packages("FedData")
install.packages("tidyterra")
library(terra)             
library(ggplot2)
library(FedData)
library(tidyterra)

# Read in Bexar County map
shp.bexar <- vect("C:\\Users\\ysw841\\Downloads\\UTSA_datathon\\political\\bexar.shp")
plot(shp.bexar)

# Create an empty list object... What is this??
raster.nlcd <- list()

# Download land cover data for Bexar County;
# Store each year in its own list element using indexing brackets
raster.nlcd[[1]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2001)
raster.nlcd[[2]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2004)
raster.nlcd[[3]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2006)
raster.nlcd[[4]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2008)
raster.nlcd[[5]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2011)
raster.nlcd[[6]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2013)
raster.nlcd[[7]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2016)
raster.nlcd[[8]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2019)
raster.nlcd[[9]] <- get_nlcd(template = shp.bexar, label = "shp.bexar", year = 2021)

# set names of list elements
names(raster.nlcd) <- c("Year2001","Year2004","Year2006","Year2008","Year2011","Year2013","Year2016","Year2019","Year2021")

# plot each year
plot(raster.nlcd$Year2001)
plot(raster.nlcd$Year2004)
plot(raster.nlcd$Year2006)
plot(raster.nlcd$Year2008)
plot(raster.nlcd$Year2011)
plot(raster.nlcd$Year2013)
plot(raster.nlcd$Year2006)
plot(raster.nlcd$Year2019)
plot(raster.nlcd$Year2021)
