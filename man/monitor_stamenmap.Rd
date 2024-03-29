% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitor_stamenmap.R
\name{monitor_stamenmap}
\alias{monitor_stamenmap}
\title{Create a static map of ws_monitor object}
\usage{
monitor_stamenmap(
  ws_monitor,
  slice = get("max"),
  breaks = AQI$breaks_24,
  colors = AQI$colors,
  width = 640,
  height = 640,
  centerLon = NULL,
  centerLat = NULL,
  zoom = NULL,
  maptype = "terrain",
  grayscale = FALSE,
  rasterBrick = NULL,
  cex = par("cex") * 2,
  pch = 16,
  ...
)
}
\arguments{
\item{ws_monitor}{\emph{ws_monitor} object}

\item{slice}{either a time index or a function used to collapse the time
axis -- defautls to \code{get('max')}}

\item{breaks}{set of breaks used to assign colors}

\item{colors}{a set of colors for different levels of air quality data
determined by \code{breaks}}

\item{width}{width of image, in pixels}

\item{height}{height of image, in pixels}

\item{centerLon}{map center longitude}

\item{centerLat}{map center latitude}

\item{zoom}{map zoom level}

\item{maptype}{map type}

\item{grayscale}{logical, if TRUE the colored map tile is rendered into a
black & white image}

\item{rasterBrick}{optional RGB rasterBrick object returned from
\code{staticmap_get~Brick})}

\item{cex}{character expansion for points}

\item{pch}{plotting character for points}

\item{...}{arguments passed on to \code{staticmap_plotRasterBrick()}
(\emph{e.g.} destfile, cex, pch, etc.)}
}
\value{
Plots a map loaded from arcGIS REST with points for each monitor.
}
\description{
Plots amap showing \emph{ws_monitor} locations and values.

#' Available \code{maptypes} include:
\itemize{
\item{terrain}
\item{toner}
\item{watercolor}
}

See \code{\link{staticmap_getStamenmapBrick}} for details.

If \code{centerLon}, \code{centerMap} or \code{zoom} are not specified,
appropriate values will be calcualted using data from the
\code{ws_monitor$meta} dataframe.
}
\examples{
\donttest{
# Fail gracefully if any resources are not available
try({

library(PWFSLSmoke)

N_M <- Northwest_Megafires
# monitor_leaflet(N_M) # to identify Spokane monitorIDs
Spokane <- monitor_subsetBy(N_M, stringr::str_detect(N_M$meta$monitorID,'^53063'))
Spokane <- monitor_subset(Spokane, tlim=c(20150815, 20150831))
monitor_stamenmap(Spokane)

}, silent = FALSE)
}

}
\seealso{
\code{\link{staticmap_getStamenmapBrick}}

\code{\link{staticmap_plotRasterBrick}}
}
\keyword{ws_monitor}
