#' @keywords ws_monitor
#' @export
#' @title Isolate Individual Monitors
#' @param ws_monitor \emph{ws_monitor} object
#' @param xlim optional vector with low and high longitude limits
#' @param ylim optional vector with low and high latitude limits
#' @param tlim optional vector with start and end times (integer or character representing YYYYMMDD[HH] or \code{POSIXct})
#' @param stateCodes optional vector of stateCodes
#' @param monitorIDs optional vector of monitorIDs
#' @param timezone Olson timezone passed to \code{\link[MazamaCoreUtils]{parseDatetime}} when parsing numeric \code{tlim}
#' @return A list of isolated ws_monitor objects.
#' @description Filters \code{ws_monitor} according to the parameters
#' passed in.  If any parameter is not specified, that parameter will not be used in the filtering.
#'
#' After filtering, each monitorID found in \code{ws_monitor} is extracted
#' and its \code{data} dataframe is restricted to the times from when that monitor first
#' datapoint until its last datapoint.
#'
#' This function is useful when \emph{ws_monitor} objects are created for
#' mobile monitors that are deployed to different locations in different years.
#' @seealso \link{monitor_subset}
#' @examples
#' N_M <- Northwest_Megafires
#' # monitor_leaflet(N_M) # to identify Spokane monitorIDs
#' Spokane <- monitor_subsetBy(N_M, stringr::str_detect(N_M$meta$monitorID,'^53063'))
#' Spokane$meta$monitorID
#' monitorList <- monitor_isolate(Spokane)
#' names(monitorList)

monitor_isolate <- function(
  ws_monitor,
  xlim = NULL,
  ylim = NULL,
  tlim = NULL,
  monitorIDs = NULL,
  stateCodes = NULL,
  timezone = "UTC"
) {

  # Sanity check
  if ( monitor_isEmpty(ws_monitor) ) stop("ws_monitor object contains zero monitors")

  # Isolate individual monitors
  monList <- list()
  for (monitorID in names(ws_monitor$data)[-1]) {
    mon <- monitor_subset(ws_monitor, xlim=xlim, ylim=ylim, tlim=tlim,
                          monitorIDs=monitorID, dropMonitors=TRUE, timezone=timezone)
    monList[[monitorID]] <- monitor_trim(mon)
  }

  return(monList)
}
