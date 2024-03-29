% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/epa_loadAnnual.R
\name{epa_loadAnnual}
\alias{epa_loadAnnual}
\title{Load annual EPA monitoring data}
\usage{
epa_loadAnnual(
  year = NULL,
  parameterCode = NULL,
  baseUrl = "https://haze.airfire.org/monitoring",
  dataDir = NULL
)
}
\arguments{
\item{year}{Desired year (integer or character representing YYYY).}

\item{parameterCode}{Pollutant code.}

\item{baseUrl}{Base URL for 'annual' EPA data files.}

\item{dataDir}{Local directory containing 'annual' data files.}
}
\value{
A \emph{ws_monitor} object with EPA data.
}
\description{
Loads pre-generated .RData files containing annual
EPA data.

EPA parameter codes include:
\enumerate{
\item{88101}{ -- PM2.5 FRM/FEM Mass (begins in 2008)}
\item{88502}{ -- PM2.5 non FRM/FEM Mass (begins in 1998)}
}

Avaialble RData and associated log files can be seen at:
\href{https://haze.airfire.org/monitoring/EPA/RData/}{https://haze.airfire.org/monitoring/EPA/RData/}
}
\examples{
\dontrun{
# Fail gracefully if any resources are not available
try({

epa_loadAnnual(2000, "88502") \%>\%
  monitor_subset(stateCodes = 'WA', tlim=c(20000701,20000801)) \%>\%
  monitor_map()

}, silent = FALSE)
}
}
\references{
\href{https://aqs.epa.gov/aqsweb/airdata/download_files.html#Raw}{EPA AirData Pre-Generated Data Files}
}
\keyword{EPA}
