
##setwd("~/SynologyDrive/R-code/birdnet")
#StationName="Trailridge"
#StationType="bw"

#' Create directories and subdirectories for a bird listening station
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download. Required parameters are:
#'  - *myparms$mystn:* station key which is used to pull the full station name from the "stations.csv" file. See 'stns_stnm()' for details.
#'  - *myparms$mysrc:* station type for data, i.e., "puc", "bw" or "pi"
#'
#' @param stnf Relative pathname to file holding listening station information.  Default path when stnf="" is "data/brddat/stations.csv".
#' @param rootd Default folder for storing station data with a default of "data"
#'
#' @seealso
#' - [stns_plst_set()] for parameter list structure
#' - [stns_stnm()] for accessing the full station name using the station key and src
#' @returns nothing
#' @export
#'
#'
#'
#' @examples
#' myparms<-stns_plst_set("Munn","pi",2026,9)
#' str(myparms)
#' stns_new(myparms)
stns_new<-function(myparms,rootd="aviary",stnf=""){
 StationName= stns_stnm(myparms,stnf="")
 StationType=myparms$mysrc
  newRoot=paste(rootd,StationName,paste(StationName,StationType,sep="-"),sep="/")
  dir.create(file.path(newRoot),recursive = TRUE,showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"archives",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"archives-csv",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"brdbrain",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"brdbrain-csv",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-comm",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-sp",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-stn",sep="/")),showWarnings = FALSE)
}
