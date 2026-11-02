

#' Create a filename with included path
#'
#'
#' Create a filename for opening or
#'   saving a bird detection station data file
#'
#' @param pth  Path to file
#' @param stn  Name of detection station
#' @param hdr  Prefix to add to file name
#' @param sfx  Suffix to add to file name
#' @param extn File extension type, e.g., ".txt" or ".csv"
#'
#' @return    File Name including path
#' @export
#'
#' @examples
#' fnmp(pth="pth",stn="stn", sfx = "sfx",hdr = "hdr",extn=".ext")
#' fnmp("data/Munn/Munn-pi/archives","Munn", sfx = "pi",hdr = "2024-05-12-detections")
#' fnmp(stn = "Munn", sfx = "pi",hdr = "2024-05-12-detections")
#'
#'
#'
fnmp <- function ( pth = "",stn ="", hdr = "", sfx = "", extn = ".csv")
{
  if(sfx != "")sfx = paste("-",sfx,sep="")
  if(hdr != "")hdr = paste(hdr,"-",sep="")
  flnm = paste(hdr, stn, sfx, extn, sep = "")
  if(pth == "") {
    return(flnm)
  } else {
    return (file.path(pth,flnm,fsep = .Platform$file.sep) )}
}
