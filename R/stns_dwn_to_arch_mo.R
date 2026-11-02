#' Saves a month of raw bird song data to archive folders
#'
#' Downloaded data attached to the 'myparms' list argument is saved in subfolders to the listening station folder as ".csv" and ".rsd" files.
#' - The CSV file is saved in an "archives-csv" subfolder.
#' - The RSD file is saved in an "archives" subfolder
#'
#' @param myparms List of parameters defining data to be saved as well as raw file of monthly data
#'
#' @returns Parameter list as pass through
#'
#' @seealso [stns_plst_set()]
#'
#' @export
#'
#' @examples
#'
stns_dwn_to_arch_mo <-function(myparms){
  myBirds=myparms$brdfrm
  ##---save download as ".csv"
  svfilenm=dat_fldrfnmp(myparms,sbfldr = "archives-csv",extn=".csv")
  utils::write.csv(myBirds,svfilenm, row.names = FALSE)
  print(paste("Archive file saved to: ",svfilenm, sep=""))
  ##---save download as ".rds"
  svfilenmRDS=dat_fldrfnmp(myparms,sbfldr = "archives",extn=".rds")
  saveRDS(myBirds, svfilenmRDS)
  print(paste("Archive file saved to: ",svfilenm, sep=""))
  return(myparms)
}

