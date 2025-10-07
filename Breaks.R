## cp -p ~/Oktatás/diploma/ÁgostonÁlmosPál/TesMODIS2025/*Tes*
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

## Pixel reliability
QA_Tes <- mt_subset(product = "MOD13Q1",
                    lat = 47.270344,
                    lon = 18.04669,
                    band = "250m_16_days_pixel_reliability",
                    start = "2001-01-01",
                    end = "2025-09-30",
                    km_lr = 1,
                    km_ab = 1,
                    site_name = "Tes",
                    internal = TRUE,
                    progress = TRUE)

## Save for emergency
save(VI_Tes, file = "VI_Tes.RData")
save(QA_Tes, file = "QA_Tes.RData")

## Load
load("VI_Tes.RData");load("QA_Tes.RData")


## convert df to raster
VI_r <- mt_to_terra(df = VI_Tes)
QA_r <- mt_to_terra(df = QA_Tes)

## clean the data
## create mask on pixel reliability flag set all values <0 or >1 NA
m <- QA_r
m[(QA_r < 0 | QA_r > 1)] <- NA # continue working with QA 0 (good data), and 1 (marginal data)

## apply the mask to the NDVI raster
VI_m <- terra::mask(VI_r, m, maskvalue=NA, updatevalue=NA)

## plot the 4th image (time step)
plot(m,46) # plot mask

## more masks
par(mfrow=c(2,2))
for(tti in 51:54)
    plot(m,tti)

## more VI
par(mfrow=c(4,3), mar=c(0,0,0,0))
for(tti in 51:62)
    plot(VI_r,tti)

# plot the 10th image (time step)
plot(m,46) # plot mask
plot(VI_m,46) # plot cleaned NDVI raster

## Map with leaflet
library(leaflet)
r <- raster(VI_m[[3]]) # Select only the third layer (as a RasterLayer)
pal <- colorNumeric(c("#ffffff", "#4dff88", "#004d1a"), values(r),  na.color = "transparent")

map <- leaflet() %>% addTiles() %>%
  addRasterImage(r, colors = pal, opacity = 0.8) %>%
  addLegend(pal = pal, values = values(r),
    title = "NDVI")

map # open in web browser.

## the dimensions of the raster are: 9x9

px <- 41 # pixel number, estimated based on above map
tspx <- timeser(unlist(VI_m[px]),as.Date(names(VI_m), "%Y-%m-%d")) # convert pixel "px" to a time series
plot(tspx, main = 'NDVI') # NDVI time series cleaned using the "reliability information"

## Strict break identification
breaks <- bfastlite(tspx, response ~ trend + harmon, order = 2, breaks = "LWZ")
breaks

## Liberal break identification
breaks <- bfastlite(tspx, response ~ trend + harmon, order = 3, breaks = "BIC")
breaks

## Different pixel
px <- 32
tspx <- timeser(unlist(VI_m[px]),as.Date(names(VI_m), "%Y-%m-%d"))
breaks <- bfastlite(tspx, response ~ trend + harmon, order = 3, breaks = "BIC")
#breaks <- bfastlite(tspx, response ~ trend, order = 3, breaks = "BIC")
breaks ## no breaks at all

### Entire raster
## Functions
# The code for getting a date from above, in a function
# index is which breakpoint to list, tspx is the original time series
IndexToDate <- function(index, tspx, breaks) {
  dates.no.na <- as.numeric(time(tspx))
  dates.no.na[is.na(tspx)] <- NA
  dates.no.na <- na.omit(dates.no.na)
  dates.no.na[breaks$breakpoints$breakpoints[index]]
}

bflRaster <- function(pixels, dates, timeser, IndexToDate) {
  library(zoo)
  library(bfast)
  tspx <- timeser(pixels, dates)
  breaks <- bfastlite(tspx, response ~ trend + harmon, order = 3, breaks = "BIC")

   #if two breaks are recorded keep the break with the largest magnitude
  if (length(breaks$breakpoints$breakpoints)>1)
      breaks$breakpoints$breakpoints<-which.max(breaks$breakpoints$breakpoints)

  # If no break, return NAs
  if (is.na(breaks$breakpoints$breakpoints))
    return(c(NA,NA))

  # Get break with highest magnitude
  mags <- magnitude(breaks$breakpoints)
  maxMag <- which.max(mags$Mag[,"RMSD"])

  return(c(IndexToDate(maxMag, tspx, breaks), mags$Mag[maxMag, "RMSD"]))
}

# This will take a while: BFAST Lite is not as fast as BFAST Monitor.
system.time({
bflR <- app(VI_m, bflRaster, dates=as.Date(names(VI_m), "%Y-%m-%d"), timeser=timeser, IndexToDate=IndexToDate)
})
