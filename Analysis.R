## For 41 pixel
px <- 41 # pixel number, estimated based on above map
tspx <- timeser(unlist(VI_m[px]),as.Date(names(VI_m), "%Y-%m-%d")) # convert pixel "px" to a time series

png("Pixel41.png", width = 18, height = 5, units = "cm", res = 300) 
plot(tspx, main = 'NDVI') # NDVI time series cleaned using the "reliability information"
dev.off()
