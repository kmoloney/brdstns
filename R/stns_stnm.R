#' Get full station name
#'
#' Extracts a full station name from a locally stored "station.csv" database file using values for the key ('*Stn_key*') and src ('*Src*') associated with the unique station
#'
#'
#'
#' @param myparms  List containing station parameters set with 'bw_parmlist()'
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'@seealso
#' - [stns_db()] for information on the variables in the stations database file.
#' - [stns_plst_set()] for information on the parameter list ('myparms') argument
#' @returns Full station name: the '*Station*' variable in the 'stations.csv' database
#' @export
#'
#' @examples
#' ##----------------------------
#' ##---- set up parameters for function call
#' ##----------------------------
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' myparms=stns_plst_set("Cedar","puc")
#' str(myparms)
#' ##----------------------------
#' ##---- station entry found in stations database
#' ##----------------------------
#' stns_stnm(myparms,stnf=mystns)
#' ##----------------------------
#' ##---- The stations database file is not found
#' ##----------------------------
#' stns_stnm(myparms,stnf="dummy")
#' ##----------------------------
#' ##---- station entry not found in stations database
#' ##----------------------------
#' myparms=stns_plst_set("Cedars","puc")
#' stns_stnm(myparms,stnf=mystns)
#'
stns_stnm <- function(myparms,stnf=""){
  if(stnf=="")stnf=myparms$mystnsf
if(file.exists(stnf)){
  if(stns_chk_stnp(myparms,stnf)){
       tmpStns<-stns_db_p(myparms,stnf)
       mystn=tmpStns$Station[tmpStns$Stn_key==myparms$mystn & tmpStns$Src==myparms$mysrc]
     } else {
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
