#' Get unique station id value
#'
#' `stns_id()` returns a unique station ID number for a specific station and station source combination.
#' Station ids are stored locally in "data/brddat/stations.csv" which must be in the current working directory. It is a user maintained file.
#' - Station ids for "puc" and "bw" databases are set by the administrators at [Birdweather.com](http://birdweather.com).
#' - Station ids for "pi" stations can be set locally since BirdNET-Pi stations are not assigned unique id numbers.
#'
#'
#' @param stn_key Short name for station
#' @param stn_src Data source type, i.e., "pi", "bw" or "puc"
#' @param stnf Path to stations.csv file, default is "data/brddat/stations.csv"
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
#' stns_id("Cedar","puc",stnf=myfile)
#' stns_id("NSW","bw",stnf=myfile)
#' stns_id("NSW","pi",stnf=myfile)
stns_id <- function(stn_key,stn_src,stnf=""){
  tmpStns<-stns_db(stnf)
  myid=tmpStns$id[tmpStns$Stn_key==stn_key & tmpStns$Src==stn_src]
return(myid[1])
}
