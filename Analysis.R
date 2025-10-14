## For 41 pixel
px <- 41 # pixel number, estimated based on above map
tspx <- timeser(unlist(VI_m[px]),as.Date(names(VI_m), "%Y-%m-%d")) # convert pixel "px" to a time series

png("Pixel41.png", width = 18, height = 4, units = "cm", res = 300)
par(mar = c(2.1,4.1,0.2,0.2), las = 1)
plot(tspx, xlab = "", ylab = "VI") # NDVI time series cleaned using the "reliability information"
dev.off()

plot(window(tspx,2001,2002))
