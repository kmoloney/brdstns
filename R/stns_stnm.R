#' Returns station name
#'
#' Extracts a full station name from a locally stored "station.csv" data table using a short name and station src as keys
#'
#'
#'
#' @param myparms  List of station parameters set with 'bw_parmlist()'
#' @param stnf Relative pathname to file holding listening station information.  Default path when stnf="" is "data/brddat/stations.csv".
#'
#'@seealso
#' - [stns_db()] for more information
# #' - [bw_plst_set()] for parameter list information
#' @returns Full station name
#' @export
#'
#' @examples
#' myparms=stns_plst_set("Cedar","puc",2026,9)
#' mystns=system.file("extdata/stations.csv", package = "brdbrain")
#' ##---- station entry found in stations database
#' stns_stnm(myparms,stnf=mystns)
#' ##---- station entry not found in stations database
#' ##---- the station key value 'myparms$mystn'  is returned as the station name
#' myparms=stns_plst_set("Cedars","puc",2026,9)
#' stns_stnm(myparms,stnf=mystns)
#' ##---- The stations database file is not found so the station key value 'myparms$mystn'
#' ##---- is returned as the station name
#' stns_stnm(myparms,stnf="dummy")
#'
stns_stnm <- function(myparms,stnf=""){
  if(stnf=="")stnf="data/brddat/stations.csv"
if(file.exists(stnf)){
   tmpStns<-stns_db(stnf)
   mystn=tmpStns$Station[tmpStns$Stn_key==myparms$mystn & tmpStns$Src==myparms$mysrc]
   if(is.na(mystn[1])){
     mystn=myparms$mystn
    print(paste("Station not found in stations file \'",stnf,"\'",sep=""))
    print(paste("Setting station name to \"" ,myparms$mystn , "\" using 'myparms$Stn_key' ",sep=""), quote = FALSE)
    return(mystn)
   }
   return(mystn[1])
} else {
     print(paste("Station file \'",stnf, "\' not found. ",sep=""), quote = FALSE)
     print(paste("Setting station name to \"",myparms$mystn, "\" using the station key value 'myparms$mystn' ",sep=""), quote = FALSE)
     return(myparms$mystn)
   }
}
