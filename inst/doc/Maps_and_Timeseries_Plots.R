## ---- echo = FALSE------------------------------------------------------------
knitr::opts_chunk$set(fig.width = 7, fig.height = 5)

## ----Northwest_Megafires, message = FALSE-------------------------------------
suppressPackageStartupMessages(library(PWFSLSmoke))

PacNW <- Northwest_Megafires
PacNW_24 <- monitor_rollingMean(PacNW, width = 24)

## ----map----------------------------------------------------------------------
monitor_map(PacNW_24, slice = max)
addAQILegend(title = "Max AQI", cex = 0.7)

## ----leaflet------------------------------------------------------------------
# Commented out for the vignette
#monitor_leaflet(PacNW_24, slice = max)

## ----dygraph------------------------------------------------------------------
NezPerceIDs <- c("160571012_01", "160690012_01", "160690013_01",
                 "160690014_01", "160490003_01", "160491012_01")
NezPerce <- monitor_subset(PacNW, monitorIDs = NezPerceIDs)
monitor_timeseriesPlot(NezPerce, style = 'gnats')
addAQILines()
addAQILegend(cex = 0.7)

## ----august-------------------------------------------------------------------
PacNW <- monitor_subset(PacNW, tlim = c(20150801, 20150831),
                        timezone = "America/Los_Angeles")
PacNW_24 <- monitor_subset(PacNW_24, tlim = c(20150801, 20150831),
                           timezone = "America/Los_Angeles")
NezPerce <- monitor_subset(NezPerce, tlim = c(20150801, 20150831),
                           timezone = "America/Los_Angeles")

## ----dailyBarplot, fig.height = 10--------------------------------------------
layout(matrix(seq(6)))
opar <- par(mar = c(1,1,1,1))
on.exit(par(opar))
for (monitorID in NezPerceIDs) {
  siteName <- NezPerce$meta[monitorID, 'siteName']
  monitor_dailyBarplot(
    NezPerce, 
    monitorID = monitorID, 
    main = siteName, 
    axes = FALSE
  ) 
}
par(opar)
layout(1)

## ----acute--------------------------------------------------------------------
data <- PacNW$data[,-1] # omit 'datetime' column
maxPM25 <- apply(data, 2, max, na.rm = TRUE) # maximum value at each site
worstAcute <- names(sort(maxPM25, decreasing = TRUE))[1:6] # monitorIDs for the six worst sites in PacNW
dplyr::intersect(worstAcute, NezPerceIDs)
PacNW$meta[worstAcute[1],c('siteName','countyName','stateCode')]

## ----dailyStatistic, warning = FALSE------------------------------------------
PacNW_dailyAvg <- monitor_dailyStatistic(PacNW, FUN = mean, minHours = 20)
data <- PacNW_dailyAvg$data[,-1]
unhealthyDays <- apply(data, 2, function(x) { sum(x >= AQI$breaks_24[4], na.rm = TRUE) })
worstChronic <- names(sort(unhealthyDays, decreasing = TRUE))[1:6]
dplyr::intersect(worstChronic, NezPerceIDs)
PacNW$meta[worstChronic[1],c('siteName','countyName','stateCode')]

## ----staticMap, fig.width=5, fig.height=5, eval=FALSE, echo=FALSE-------------
#  fireLons <- c(-118.461, -117.679, -120.039, -119.002, -119.662)
#  fireLats <- c(48.756, 46.11, 47.814, 48.338, 48.519)
#  monitor_staticMap(
#    PacNW_dailyAvg,
#    slice = max,
#    maptype = 'terrain',
#    centerLon = -118,
#    centerLat = 47,
#    zoom = 7
#  )
#  addIcon('redFlame', fireLons, fireLats, expansion = .002)
#  addAQILegend(cex = 0.8)
#  title("August, 2015", line = -1.5, cex.main = 2)

## ----tribalMonitors_daily-----------------------------------------------------
Omak <- monitor_subset(PacNW, monitorIDs = "530470013_01")
Kamiah <- monitor_subset(PacNW, monitorIDs = "160490003_01")
layout(matrix(seq(2)))
monitor_dailyBarplot(
  Omak, 
  main = "August 2015 Daiy AQI -- Omak, WA",
  labels_x_nudge = 0.8, 
  labels_y_nudge = 250
)
monitor_dailyBarplot(
  Kamiah, 
  main="August Daily AQI -- Kamiah, ID",
  labels_x_nudge = 0.8, 
  labels_y_nudge = 250
)
layout(1)

