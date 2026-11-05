############################
###     fldrp      ###
############################
#' Create folder path for data file storage
#'
#' Produces a relative path name under the working directory based on root path ("myroot"), station name ("stn"),
#' station type ("sfx"), and subfolder ("sbfldr"), i.e., "myroot/stn/stn-sfx/sbfldr"
#'
#' @param myroot Starting directory for path  holding data for the project with the root being the working directory
#' @param stn Bird detection station name
#' @param sbfldr Subfolder for holding data, e.g., "downloads", "archives", etc.
#' @param sfx  The suffix represents the source of the station data data:
#' - *"pi": * BirdNET-Pi data obtained directly from its SQLite database
#' - *"bw": *  BirdNET-Pi data obtained by download from Birdweather.com
#' - *"puc": *  PUC data obtained by download from Birdweather.com
#'
#' @return Path to a data folder
#' @export
#'
#' @examples
#' fldrp(stn = "Munn",sbfldr = "archives", sfx = "bw")
#' fldrp(stn = "Munn")
#' fldrp()
#'
fldrp <- function (myroot = "data",stn = "", sbfldr = "", sfx = "")
{
  fldr_path = myroot
  if(sfx != "") sfx = paste("-",sfx, sep = "")

  if(stn != ""){
    if (sbfldr == "") {
      if (sfx == ""){
        fldr_path =  file.path(fldr_path,stn,  fsep = .Platform$file.sep)                  #paste("data/", stn, "/", sep = "")
      } else {
        fldr_path =  file.path(fldr_path,stn, paste(stn,sfx,sep = ""), fsep = .Platform$file.sep) } #paste("data/", stn, "/", stn, sfx,"/", sep = "")}
    } else {
      if (sfx != ""){
        fldr_path = file.path(fldr_path,stn, paste(stn,sfx,sep = ""), sbfldr, fsep = .Platform$file.sep)       # paste("data/", stn, "/", stn,sfx,"/", sbfldr, "/", sep = "")
      } else {
        fldr_path =  file.path(fldr_path,stn,  sbfldr, fsep = .Platform$file.sep) #paste("data/", stn, "/", sbfldr, "/", sep = "")
      }
    }
  } else {
    if (sbfldr != "") fldr_path = file.path(fldr_path,sbfldr, fsep = .Platform$file.sep)
  }
  return(fldr_path)
}

