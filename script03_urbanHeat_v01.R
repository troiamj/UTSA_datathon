########################################################################################################
# Install and load libraries
#install.packages("terra")  # this package facilitates mapping, geospatial analysis
library(terra)             
library(ggplot2)

########################################################################################################
# source of global climate data --> https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_tmax.zip
# read in worldclim data; this is a raster data layer (grid of cells with maximum air temperature)
raster.tmax <- rast("C:\\Users\\ysw841\\Downloads\\UTSA_datathon\\worldclim\\wc2.1_30s_tmax_08.tif")

# plot map of temperature
plot(raster.tmax)

########################################################################################################
# create a data frame with lat-lon coordinates representing longitudinal transect through the city center
city.center <- c(32.7869619997666,  -96.95092210910796)    # Dallas Fort Worth --> get this manually from Google Maps
#city.center <- c(39.7683574867361,  -86.15812763742959)    # Indianapolis--> get this manually from Google Maps
#city.center <- c(35.1487666710542,  -90.04854128444293)    # Memphis--> get this manually from Google Maps
#city.center <- c(38.9003407945899,  -77.02162617725402)    # Washington DC --> get this manually from Google Maps
#city.center <- c(44.9916240119576,  -93.26256409761982)    # Minneapolis --> get this manually from Google Maps
#city.center <- c(38.6283122068098,  -90.20020914082447)    # St Louis --> get this manually from Google Maps
#city.center <- c(29.4304403555662,  -98.49794652978048)    # San Antonio --> get this manually from Google Maps
#city.center <- c(38.5722862752035, -121.50297187038171)    # Sacramento --> get this manually from Google Maps

# set spatial resoluton and scale
spatial_res <- 0.03   # in degrees longitude
spatial_ext <- 101    # number of points along gradient

# create a vector of longitudes
lon <- c(seq(from = city.center[2]-spatial_res,
             by = -spatial_res,
             length.out = (spatial_ext-1)/2),
         city.center[2],
         seq(from = city.center[2]+spatial_res,
             by = +spatial_res,
             length.out = (spatial_ext-1)/2))

# create a vector of latitudes
lat <- rep(city.center[1], spatial_ext)

# combine longitude and latitude into a dataframe
dframe.gradient_urban <- data.frame(lon, lat)

# convert lat-lon gradient to a spatial object (akin to a point shapefile in ArcGIS)
points.gradient_urban <- vect(as.matrix(dframe.gradient_urban), crs="+proj=longlat +datum=WGS84")

########################################################################################################
# replot map
plot(raster.tmax)
# add the gradient of points
plot(points.gradient_urban, add = TRUE, pch = 3)
# add city center
plot(points.gradient_urban[51], add = TRUE, pch = 19, col = "red")

# replot map zooming in on central US
plot(raster.tmax, xlim = c(-101,-93), ylim = c(25,40))
# add the gradient of points
plot(points.gradient_urban, add = TRUE, pch = 3)
# add city center
plot(points.gradient_urban[51], add = TRUE, pch = 19, col = "red")

# replot map zooming in on city center
plot(raster.tmax, xlim = c(-99,-95), ylim = c(32,34))
# add the gradient of points
plot(points.gradient_urban, add = TRUE, pch = 3)
# add city center
plot(points.gradient_urban[51], add = TRUE, pch = 19, col = "red")

########################################################################################################
# for each point along the transect, extract temperature value from the raster
dframe.gradient_urban.tmax <- extract(raster.tmax, points.gradient_urban)

# merge temperature and longitude back together
dframe.gradient_urban <- data.frame(dframe.gradient_urban, dframe.gradient_urban.tmax)

########################################################################################################
# make publication-quality plot
plot_08 <- ggplot(NULL) + 
  theme_bw() +
  labs(x = "Longitude (°W)",              # customize your axis labels
       y = "Maximum temperature (°C)") +  # customize your axis labels
  geom_point(aes(x = lon, y = wc2.1_30s_tmax_08),  dframe.gradient_urban, size = 3, shape = 16, alpha = 0.5) +
  geom_vline(xintercept = city.center[2]) +
  geom_smooth(aes(x = lon, y = wc2.1_30s_tmax_08),  dframe.gradient_urban)

print(plot_08)

########################################################################################################