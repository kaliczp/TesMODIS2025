library(scales)

png()
ido <- 2003
tspxakt <- window(tspx,ido,ido+1)
tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
plot(tspxNINCSido,
     xlim = c(0,1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = "",
     col = alpha("black", 0.5),
     lwd = 5
     )
for(ido in 2004:2021) {
    tspxakt <- window(tspx,ido,ido+1)
    tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
    lines(tspxNINCSido,
          col = alpha("black", 0.5),
          lwd = 5
          )
}
ido <- 2003
tspxakt <- window(tspx,ido,ido+1)
tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
lines(tspxNINCSido,
      col = "red",
      lwd = 5
      )
dev.off()
