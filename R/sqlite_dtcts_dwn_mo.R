
#' Extract month of detection data from a Birdnet-PI SQLite database
#'
#' A file dialog is presented to open an SQLite database downloaded from a Birdnet-PI station.
#' A monthly subset of observation data for the timeframe specified is extracted and returned via the parameter list.
#'
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download.
#' @seealso [stns_plst_set()] for parameter list structure
#'
#' @returns Parameter list including retrieved month of Birdnet-PI detections stored as 'myparms$brdfrm'
#'
#' @importFrom RSQLite dbConnect dbDisconnect SQLite dbReadTable
#'
#' @export
#'
#' @examples
sqlite_dtcts_dwn_mo<-function(myparms){
  # 1. Connect to the SQLite database
  con <- dbConnect(SQLite(), file.choose() )
  # 2. Read the entire table into a data frame
  myBirds <- dbReadTable(con, "detections")
  dbDisconnect(con)
  # 3. Process the data frame
  myYr=myparms$myyr
  myMo=myparms$mymo
  ##--- set start and end dates
  strtDate=paste(myYr,moStr(myMo),"01",sep="-")
  if(myMo<12){
    endDate=paste(myYr,moStr(myMo+1),"01",sep="-")
  } else {
    endDate=paste(myYr+1,"01","01",sep="-")
  }
#  myYrPrefix=paste(myYr,"-",sep="")
  ##--- select start and end dates
  myBirds=myBirds[myBirds$Date>=strtDate,]
  myBirds= myBirds[myBirds$Date<endDate,]
  myparms$brdfrm=myBirds
  return(myparms)
}
