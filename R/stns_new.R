
##setwd("~/SynologyDrive/R-code/birdnet")
#StationName="Trailridge"
#StationType="bw"
###### NOTE: Modify this to create subdirectories as needed
#' Create directories and subdirectories for a bird listening station
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download. Required parameters are:
#'  - *myparms$mystn:* station key which is used to pull the full station name from the "stations.csv" file. See 'stns_stnm()' for details.
#'  - *myparms$mysrc:* station type for data, i.e., "puc", "bw" or "pi"
#'
#' @param stnf Relative pathname to file holding listening station information.  Default path when stnf="" is "data/brddat/stations.csv".
#' @param root Default folder for storing station data with a default of "data"
#'
#' @importFrom fs dir_tree
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
#'\dontshow{.old_wd <- setwd(tempdir())}
#' myparms<-stns_plst_set("Cedar","puc",2026,9)
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' # Create a new directories and subdirectories in the default location
#' stns_new(myparms,stnf=mystns)
#' fs::dir_tree("Aviary")
#'
#' # Create new directories and subdirectories under a non-default directory, e.g., Test/
#' stns_new(myparms,root="Test",stnf=mystns)
#' myparms<-stns_plst_set("NSW","pi",2026,9)
#' stns_new(myparms,root="Test",stnf=mystns)
#' myparms<-stns_plst_set("NSW","bw",2026,9)
#' stns_new(myparms,root="Test",stnf=mystns)
#' fs::dir_tree("Test")
#'\dontshow{setwd(.old_wd)}

stns_new<-function(myparms,root="",stnf=""){
  if(root=="")root=brdstns::stnsroot
 StationName= stns_stnm(myparms,stnf=stnf)
 StationType=myparms$mysrc
  newRoot=paste(root,StationName,paste(StationName,StationType,sep="-"),sep="/")
  dir.create(file.path(newRoot),recursive = TRUE,showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"archives",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"archives-csv",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"brdbrain",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"brdbrain-csv",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-comm",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-sp",sep="/")),showWarnings = FALSE)
  dir.create(file.path(paste(newRoot,"detect-stn",sep="/")),showWarnings = FALSE)
}
