#' Set filename with path
#'
#' @param myparms List of station parameters set with 'bw_parmlist()'
#' @param sbfldr Subfolder where data will be stored.  This is usually 'data/stnm/stnm-src/sbfldr'
#' @param root  Root folder for station data.  The default root is the folder 'data' in the working directory.
#' @param extn File extension for the file containing the data (default of ".csv")
#' @param stnf File name and relative path to the staions database with default being 'data/brddat/stations.csv'.
#' The default is changed by entering a different file name path.
#'
#' @returns File name with its relative path
#' @export
#'
#' @seealso
#' - [dat_fldrp()]
#' - [dat_fnmp()]
#' - [stns_plst_set()]
#'
#' @examples
#' myparms=stns_plst_set("Cedar_Cottage","puc",myyr=2026,mymo=9)
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' dat_fldrfnmp(myparms,sbfldr="archives",stnf=mystns)
dat_fldrfnmp<-function(myparms,sbfldr="",root="data",extn=".csv",stnf=""){
  thepath= dat_fldrp(parmlst=myparms,sbfldr=sbfldr,root=root,stnf=stnf)
  return(dat_fnmp(myparms,mypath = thepath,extn=extn,stnf=stnf))
}
