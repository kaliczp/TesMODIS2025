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
