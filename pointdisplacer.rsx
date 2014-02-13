##[INTA]=group
##layer=vector
##disthil=number 2.4
##output=output vector

install.packages("sp")

library(sp)
library(raster)
library(rgdal)
library(pracma)

crudo <- layer
#crudo <- shapefile(input)
plot(crudo)
disthil <- 2.4

crudo <- as.data.frame(crudo)
crudo[,11:12] <- project(cbind(crudo$Longitude, crudo$Latitude), proj="+proj=tmerc +lat_0=-90 +lon_0=-69 +k=1 +x_0=2500000 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
names(crudo)[11:12] <- c("X", "Y")
crudo <- crudo[crudo$NDVI != 0,]
crudo$Xcorr <- crudo$X+cos(deg2rad(crudo$Heading))*disthil/2
crudo$Ycorr <- crudo$Y-sin(deg2rad(crudo$Heading))*disthil/2
crudo$X <- NULL
crudo$Y <- NULL
coordinates(crudo) = ~Xcorr+Ycorr
plot(crudo)
#shapefile(output, crudo)
output <- crudo

