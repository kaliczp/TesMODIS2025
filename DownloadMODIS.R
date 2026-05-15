install.packages("MODISTools")

library(MODISTools) # load package
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

## Downloading the NDVI data, starting from 2000-01-01
VI_Tes47 <- mt_subset(product = "MOD13Q1",
                    lat = 47.245739,
                    lon = 18.013064,
                    band = "250m_16_days_NDVI",
                    start = "2001-01-01",
                    end = "2025-09-30",
                    km_lr = 1,
                    km_ab = 1,
                    site_name = "Tes",
                    internal = TRUE,
                    progress = TRUE)

## Pixel reliability
QA_Tes47 <- mt_subset(product = "MOD13Q1",
                    lat = 47.245739,
                    lon = 18.013064,
                    band = "250m_16_days_pixel_reliability",
                    start = "2001-01-01",
                    end = "2025-09-30",
                    km_lr = 1,
                    km_ab = 1,
                    site_name = "Tes",
                    internal = TRUE,
                    progress = TRUE)

## Save for emergency
save(VI_Tes47, file = "VI_Tes47.RData")
save(QA_Tes47, file = "QA_Tes47.RData")
