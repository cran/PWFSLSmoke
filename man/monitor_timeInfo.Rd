% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monitor_timeInfo.R
\name{monitor_timeInfo}
\alias{monitor_timeInfo}
\title{Get time related information for a monitor}
\usage{
monitor_timeInfo(ws_monitor = NULL, monitorID = NULL)
}
\arguments{
\item{ws_monitor}{\emph{ws_monitor} object.}

\item{monitorID}{Monitor ID for a specific monitor in \code{ws_monitor} --
optional if \code{ws_monitor} only has one monitor.}
}
\value{
A dataframe with times and masks.
}
\description{
Calculate the local time for the monitor, as well as
sunrise, sunset and solar noon times, and create several temporal masks.

The returned dataframe will have as many rows as the length of the incoming
UTC \code{time} vector and will contain the following columns:

\itemize{
\item{\code{localStdTime_UTC} -- UTC representation of local \strong{standard} time}
\item{\code{daylightSavings} -- logical mask = TRUE if daylight savings is in effect}
\item{\code{localTime} -- local clock time}
\item{\code{sunrise} -- time of sunrise on each localTime day}
\item{\code{sunset} -- time of sunset on each localTime day}
\item{\code{solarnoon} -- time of solar noon on each localTime day}
\item{\code{day} -- logical mask = TRUE between sunrise and sunset}
\item{\code{morning} -- logical mask = TRUE between sunrise and solarnoon}
\item{\code{afternoon} -- logical mask = TRUE between solarnoon and sunset}
\item{\code{night} -- logical mask = opposite of day}
}
}
\details{
While the \pkg{lubridate} package makes it easy to work in local timezones,
there is no easy way in R to work in "Local Standard Time" (LST) as is often
required when working with air qualitiy data. EPA regulations mandate that
daily averages be calculated based on LST.

The \code{localStdTime_UTC} is primarily for use internally and provides
an important tool for creating LST daily averages and LST axis labeling.
}
\examples{
library(PWFSLSmoke)

carmel <- monitor_subset(Carmel_Valley, tlim = c(20160801,20160810))

# Create timeInfo object for this monitor
ti <- monitor_timeInfo(carmel)

# Subset the data based on day/night masks
data_day <- carmel$data[ti$day,]
data_night <- carmel$data[ti$night,]

# Build two monitor objects
carmel_day <- list(meta = carmel$meta, data = data_day)
carmel_night <- list(meta = carmel$meta, data = data_night)

# Plot them
monitor_timeseriesPlot(carmel_day, shadedNight = TRUE, pch = 8, col = 'goldenrod')
monitor_timeseriesPlot(carmel_night, pch = 16, col = 'darkblue', add = TRUE)
}
