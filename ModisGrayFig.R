ido <- 2003
tspxakt <- window(tspx,ido,ido+1)
tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
plot(tspxNINCSido,
     xlim = c(0,1),
     ylim = c(0.2, 1),
     xaxt = "n", xlab = "", ylab = ""
     )
for(ido in 2004:2021) {
    tspxakt <- window(tspx,ido,ido+1)
    tspxNINCSido <- ts(as.vector(tspxakt), start=0, end=1, frequency = 23)
    lines(tspxNINCSido)
}
