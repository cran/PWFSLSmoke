% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitor_dygraph.R
\name{monitor_dygraph}
\alias{monitor_dygraph}
\title{Create Interactive Time Series Plot}
\usage{
monitor_dygraph(
  ws_monitor,
  title = "title",
  ylab = "PM2.5 Concentration",
  tlim = NULL,
  rollPeriod = 1,
  showLegend = TRUE
)
}
\arguments{
\item{ws_monitor}{\emph{ws_monitor} object}

\item{title}{title text}

\item{ylab}{title for the y axis}

\item{tlim}{optional vector with start and end times (integer or character
representing YYYYMMDD[HH])}

\item{rollPeriod}{rolling mean to be applied to the data}

\item{showLegend}{logical to toggle display of the legend}
}
\value{
Initiates the interactive dygraph plot in RStudio's 'Viewer' tab.
}
\description{
This function creates interactive graphs that will be displayed
  in RStudio's 'Viewer' tab.
}
\examples{
\donttest{
# Fail gracefully if any resources are not available
try({

library(PWFSLSmoke)

# Napa Fires -- October, 2017
ca <- airnow_load(2017) \%>\%
  monitor_subset(tlim=c(20171001,20171101), stateCodes='CA')

Vallejo <- monitor_subset(ca, monitorIDs='060950004_01')

Napa_Fires <- monitor_subsetByDistance(
  ca,
  longitude = Vallejo$meta$longitude,
  latitude = Vallejo$meta$latitude,
  radius = 50
)

if ( interactive() ) {
  monitor_dygraph(Napa_Fires, title='Napa Fires in California, Oct. 2017')
}

}, silent = FALSE)
}
}
\keyword{ws_monitor}
