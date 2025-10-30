library(scales)

png("MODISgray.png", width = 6, height = 5, units = "cm", res = 300, pointsize = 10)
par(mar = c(2.1,4.1,0.2,0.2), las = 1)
ido <- 2003
tspxakt <- window(tspx,ido,ido+1)
tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
plot(tspxNINCSido,
     xlim = c(0,1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = "NDVI",
     col = alpha("black", 0.5),
     lwd = 3
     )
for(ido in 2004:2021) {
    tspxakt <- window(tspx,ido,ido+1)
    tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
    lines(tspxNINCSido,
          col = alpha("black", 0.5),
          lwd = 3
          )
}
ido <- 2003
tspxakt <- window(tspx,ido,ido+1)
tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
lines(tspxNINCSido,
      col = "red",
      lwd = 3
      )
dev.off()
