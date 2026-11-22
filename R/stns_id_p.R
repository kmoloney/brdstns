#' Get unique station id value
#'
#' `stns_id()` returns a unique station ID number for a specific station and station source combination.
#' Station ids are stored locally in "data/brddat/stations.csv" which must be in the current working directory. It is a user maintained file.
#' - Station ids for "puc" and "bw" databases are set by the administrators at [Birdweather.com](http://birdweather.com).
#' - Station ids for "pi" stations can be set locally since BirdNET-Pi stations are not assigned unique id numbers.
#'
#'
#' @param myparms  myparms
#'
#' @returns Unique id value based on station source and type. Used by [Birdweather.com](https://app.birdweather.com) to identify PUC and BirdNET-PI stations included in their databases.
#' @export
#'
#' @seealso
# #'  - [bw_grphql_dtcts_dwn_mo()] -- *functions calling 'bb_stns_id( )'*
#'  - [stns_db()] -- *functions called by 'bb_stns_id( )'*
#'
#' @examples
#' myfile <- system.file("extdata/stations.csv", package = "brdstns")
#' myparms<-stns_plst_set("Cedar","puc")
#' str(myparms)
#' ##-----------------------
#' # get id for PUC station database downloaded from birdweather.com
#' ##-----------------------
#' myparms$mystnsf=myfile
#' stns_id_p(myparms)
#' ##-----------------------
#' # get id for BirdNET-Pi station associated with SQLite database file download
#' ##-----------------------
#' myparms$mystn="NSW"
#' myparms$mysrc="pi"
#' str(myparms)
#' stns_id_p(myparms)
#' ##-----------------------
#' # get id for BirdNET-Pi station associated with database downloaded from birdweather.com
#' ##-----------------------
#' myparms$mysrc="bw"
#' str(myparms)
#' stns_id_p(myparms)
stns_id_p <- function(myparms){
  tmpStns<-stns_db(myparms$mystnsf)
  myid=tmpStns$id[tmpStns$Stn_key==myparms$mystn & tmpStns$Src==myparms$mysrc]
  return(myid[1])
}
