
#' Choose a subset of dates for analysis or to save
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download.
#' Required parameters in list are "station name", "station source", "Year" and "Month". See 'bw_plst_set()' for more information.
#' @param dy Day to select, currently not used
#'
#' @importFrom lubridate year month day
#'
#' @returns Dates selected from downloaded data
#' @export
#'
#' @examples
slct_dts <- function(myparms,dy = ""){
  stnType = myparms$mysrc
  lclfrm=myparms$brdfrm
  yr=myparms$myyr
  mo=myparms$mymo
  if(stnType == "pi")  {
    lclfrm <- lclfrm[order(lclfrm$Time),]
    lclfrm <- lclfrm[order(lclfrm$Date),]
  } else  {
    lclfrm <- lclfrm[order(lclfrm$Timestamp),]
  }
  if(yr != ""){
    frmsub <- lclfrm[(year(lclfrm[,1]) == yr),]
  } else {
    frmsub <- lclfrm
  }
  if(mo != ""){
    frmsub <- frmsub[(month(frmsub[,1]) == mo),]
  }
  if(dy != ""){
    frmsub <- frmsub[(day(frmsub[,1]) == dy),]
  }
  return(frmsub)
}
