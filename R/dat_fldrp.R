#' Produce a folder path using a parameter list
#'
#' Creates a relative path for a folder containing station data source. The path is built off of the station namee and data source.
#' The default root of the path is 'data'. A subfolder can be added to the folder path.
#'
#' @param parmlst List of station parameters set with 'bw_parmlist()'
#' @param sbfldr Subfolder where data will be stored.  This is usually 'data/stnm/stnm-src/sbfldr'
#' @param root Root folder for station data.  The default root is the folder 'data' in the working directory.
#' @param stnf  File name and relative path to the staions database with default being 'data/brddat/stations.csv'.
#' The default is changed by entering a different file name path.
#'
#' @returns
#' @export
#'
#' @seealso
#' - [stns_plst_set()]
#' - [fnmp()]
# #' - [fldrfnmp()]
#' - [stns_db()]

#'
#' @examples
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' myparm=stns_plst_set("Munn","pi",2026,3)
# dat_fldrp(myparm,stnf=mystns)
# fldrp(myparm,"archives",stnf=mystns)
# fldrp(myparm,"archives",root="data",stnf=mystns)
dat_fldrp<-function(parmlst, sbfldr="",root="data",stnf=""){
  thestn=stns_stnm(parmlst,stnf=stnf)
  thepath=  fldrp(myroot = root,stn =thestn, sbfldr =sbfldr, sfx =parmlst$mysrc)
  if(!file.exists(thepath)){
    dir.create(thepath)
  }
  return(thepath)
}
