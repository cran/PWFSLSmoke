## ----setup, include=FALSE------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 7, fig.height = 5)

## ----library, echo = FALSE-----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(PWFSLSmoke)
  
  camp_fire <- Camp_Fire
})

## ----Sacramento_2--------------------------------------------------------------------------------------
monitor_leaflet(camp_fire)

## ----Sacramento_3--------------------------------------------------------------------------------------
Sacramento <-
  camp_fire %>%
  monitor_subset(monitorIDs = '060670010_01')

monitor_timeseriesPlot(
  Sacramento,
  style='aqidots',
  pch=16,
  xlab="2018"
)
addAQIStackedBar()
addAQILines()
addAQILegend(cex=0.8)
title("Sacramento Smoke")

## ----Sacramento_4--------------------------------------------------------------------------------------
Sacramento_area <-
  camp_fire %>%
  monitor_subsetByDistance(
    longitude = Sacramento$meta$longitude,
    latitude = Sacramento$meta$latitude,
    radius = 50
  )

monitor_leaflet(Sacramento_area)

## ----Sacramento_5--------------------------------------------------------------------------------------
monitor_timeseriesPlot(Sacramento_area, 
                       style = 'gnats',
                       shadedNight = TRUE)

## ----Sacramento_6--------------------------------------------------------------------------------------
Sacramento_area %>%
  monitor_collapse() %>%
  monitor_dailyStatistic() %>%
  monitor_extractData()

## ----Sacramento_7--------------------------------------------------------------------------------------
Sacramento_area %>%
  monitor_collapse() %>%
  monitor_dailyBarplot(labels_x_nudge = 0.5,
                       labels_y_nudge = 15)

