#' @keywords ws_monitor
#' @export
#' @title Scale ws_monitor Data
#' @param ws_monitor \emph{ws_monitor} object
#' @param factor numeric used to scale the data
#' @return A \emph{ws_monitor} object with scaled data.
#' @description Scale the data in a \emph{ws_monitor} object by mutiplying it with \code{factor}.
#' @examples
#' library(PWFSLSmoke)
#'
#' wa <- monitor_subset(Northwest_Megafires, stateCodes='WA')
#' wa_zero <- monitor_scaleData(wa, 3.4)

monitor_scaleData <- function(ws_monitor, factor) {

  # Sanity check
  if ( !"ws_monitor" %in% class(ws_monitor) ) {
    stop("ws_monitor object is not of class 'ws_monitor'.")
  }

  # Sanity check
  if ( monitor_isEmpty(ws_monitor) ) stop("ws_monitor object contains zero monitors")

  ws_monitor$data[,-1] <- ws_monitor$data[,-1] * factor

  return( structure(ws_monitor, class = c("ws_monitor", "list")) )

}
