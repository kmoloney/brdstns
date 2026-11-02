#' Constructs the name for a brdbrain database file
#'
#' Creates a file name based on a list containing parameters describing the data to obtain.  See help for 'bw_plst_set()' for more details.
#' - Required variables in myparms to create a file name are short station name ('mystn'), source of the station data ('mysrc'), the year of the data ('myyr') and the month of the data ('mymo').
#'
#'
#' @param myparms Parameter list defining brdbrain data to save or load
#' @param mypath Path to file (optional)
#' @param extn  File extension for the file containing the data (default of ".csv")
#' @param stnf  File name and relative path to the staions database with default being 'data/brddat/stations.csv'.
#' The default is changed by entering a different file name path.
#'
#' @returns Filename with the option of including the relative path to the file the path argument is included in the function call.
#' @export
#'
#' @seealso
#' - [stns_plst_set()]
#' - [stns_db()] - for information on the stations database structure
#'
#' @examples
#' myparms=stns_plst_set("Cedar","puc",2026,9)
#' dat_fnmp(myparms)
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' dat_fnmp(myparms,extn=".rds",stnf=mystns)
#' dat_fnmp(myparms,mypath="data/subfldr",extn=".rds",stnf=mystns)
dat_fnmp<-function(myparms,mypath="",extn=".csv",stnf=""){
  thestn=stns_stnm(myparms,stnf=stnf)
  thehdr=paste (paste(myparms$myyr,"-",sep=""),moStr(myparms$mymo),"-detections",sep = "")
  mysfx=myparms$mysrc
  if(myparms$bbdat)mysfx="bb"
  fname=fnmp(pth=mypath,stn=thestn,hdr=thehdr,sfx=mysfx,extn=extn)
  return(fname)
}

