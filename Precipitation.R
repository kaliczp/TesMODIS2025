## from odp.met.hu
## climate/observations/hourly/ historical, recent 35116
unzip("HABP_1H_35116_20020101_20241231_hist.zip")
TesClimateFull <- read.table("HABP_1H_20020101_20241231_35116.csv", header = TRUE, sep = ";")
## After description data given in UTC
Sys.setenv(TZ="UTC")
## install.packages("xts") # If necessary
library(xts) # load xts
PrecHourly <- xts(TesClimateFull$r,as.POSIXct(as.character(TesClimateFull$Time), format = "%Y%m%d%H%M"))
## Remove possible NAs
PrecHourly[PrecHourly < -10] <- NA
plot(PrecHourly)
save(PrecHourly, file = "PrecHourly.RData")
load("PrecHourly.RData")

dev.off()
for(ttyear in 2003:2024) {
    par(new = TRUE)
    plot.zoo(cumsum(PrecHourly[as.character(ttyear)]),
             ylim = c(0,1200),
             xlab = "", xaxt = "n",
             ylab = "", yaxt = "n",
             xaxs = "i", yaxs = "i")
}
TimeForAxis <- ISOdate(2024,1:12,1)
axis(1, at = TimeForAxis , lab = FALSE)
axis.POSIXct(1, at = TimeForAxis + 15*24*60*60, format = "%b.", tcl = 0)
axis(2)

ttyear <- 2022
    par(new = TRUE)
    plot.zoo(cumsum(PrecHourly[as.character(ttyear)]),
             ylim = c(0,1200),
             col = "red", lwd = 4,
             xlab = "", xaxt = "n",
             xaxs = "i", yaxs = "i")
}
