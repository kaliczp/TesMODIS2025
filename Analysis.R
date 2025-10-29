library(zoo)

## For 41 pixel
px <- 41 # pixel number, estimated based on above map
tspx <- timeser(unlist(VI_m[px]),as.Date(names(VI_m), "%Y-%m-%d")) # convert pixel "px" to a time series

png("Pixel41.png", width = 18, height = 4, units = "cm", res = 300)
par(mar = c(2.1,4.1,0.2,0.2), las = 1)
plot(tspx, xlab = "", ylab = "VI") # NDVI time series cleaned using the "reliability information"
dev.off()

dev.off()

## Összes év vékony feketén
for(ido in 2003:2021) {
    par(new = TRUE)
    plot(window(tspx,ido,ido+1),
         xlim = c(ido, ido+1),
         ylim = c(0.2, 1),
         xaxt = "n", xlab = "", ylab = ""
         )
}

## Az egyes évek az összes évre nyomtatása
ido <- 2022
par(new = TRUE)
plot(window(tspx,ido,ido+1), lwd = 4, col = "red",
     xlim = c(ido, ido+1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = "NDVI"
     )

ido <- 2001
par(new = TRUE)
plot(window(tspx,ido,ido+1), lwd = 4, col = "blue",
     xlim = c(ido, ido+1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = "NDVI"
     )

ido <- 2002
par(new = TRUE)
plot(window(tspx,ido,ido+1), lwd = 4, col = "green",
     xlim = c(ido, ido+1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = "NDVI"
     )
