## A szükséges csomagok telepítése vagy frissítése és betöltése
packagesToInstall <- c("zoo", "bfast", "terra", "raster", "leaflet", "MODISTools", "leaflet")
# install.packages(packagesToInstall)
for(currpack in 1:length(packagesToInstall))
    library(packagesToInstall[currpack], character.only = TRUE)


# Utility function to create time series object from a numeric vector
# val_array: data array for one single pixel (length is number of time steps)
# time_array: array with Dates at which raster data is recorded (same length as val_array)
timeser <- function(val_array, time_array) {
    z <- zoo(val_array, time_array) # create zoo object
    yr <- as.numeric(format(time(z), "%Y")) # extract the year numbers
    jul <- as.numeric(format(time(z), "%j")) # extract the day numbers (1-365)
    delta <- min(unlist(tapply(jul, yr, diff))) # calculate minimum
                                                # time difference
                                                # (days) between
                                                # observations
    zz <- aggregate(z, yr + (jul - 1) / delta / 23) # aggregate into decimal year timestamps
    (tso <- as.ts(zz)) # convert into timeseries object
    return(tso)
}

## Downloading the NDVI data, starting from 2000-01-01
VI_Tes <- mt_subset(product = "MOD13Q1",
                       lat = 47.270344,
                       lon = 18.04669,
                       band = "250m_16_days_NDVI",
                       start = "2001-01-01",
                       end = "2025-09-30",
                       km_lr = 1,
                       km_ab = 1,
                       site_name = "Tes",
                       internal = TRUE,
                       progress = TRUE)
