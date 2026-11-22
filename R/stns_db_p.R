
#' Load data table with variables defining listening stations
#'
#' The default path name for the datatable is through the realtive path "data/brddat/stations.csv" under the current working directory.
#'
#' The data table loaded contains the following information:
#' - *Stn_key:* Short name of the listening station
#' - *Station:* Full name of the station (spaces are indicated by underscores)
#' - *Src:* Source of the original data
#'    - "puc" - PUC data obtained from Birdweather.com
#'   - "bw"  - BirdNET-Pi data obtained from Birdweather.com
#'   - "pi" - BirdNET-Pi data obtained directly from the SQLlite database stored on the Raspberry Pi
#' - *id:* Id number for station.
#'  The id for "pi" data is chosen ad hoc.
#'  The id's for "puc" and "bw" are set by the maintainers of Birdweather.com and obtained from the birdweather [map](https://app.birdweather.com) or [database](https://app.birdweather.com/data).
#' - *Lat:* The latitude for the station.
#' - *Lon:* The longitude for the station.
#'   - Lat and Lon coordinates are set onboard and reported by a BirdNET-PI station or are reported by GPS onboard a PUC station.
#' - *GeoF:* Sets a square geofence around the (Lat,Lon) pair set for station.
#'   - The goefence compensates for variation in location reported back by PUCs, which can be quite substantial depending upon how the GPS is set up onboard the station.
#' - *Subloc:* Boolean set to TRUE or FALSE.
#'    - Only relevant for stations that report from multiple locations (primarily PUCs). If Subloc is TRUE then there should be an entry in a "locations.csv" file for each separate location to be analyzed with appropriate geofencing.
#' - *TZ:* Time zone of station/location
#' - *Bw_name:* Name given to station in Birdweather database.
#'   - Names in puc are simple names.
#'   - Names for BirdNET-PI stations are given by station owner and a prefix of "BirdNET-Pi - " is added as a prefix by the Birdweather site for "bw" data.
#'
#' **Example 'stations.csv' data table**
#' \tabular{cccccccccccccc}{
#'   **Stn_key** \tab **Station** \tab **Src** \tab **id** \tab **Lat** \tab **Lon** \tab **GeoF** \tab **substat** \tab **TZ** \tab **Bw_name**\cr
#'  Munn \tab 	Munn \tab 	pi \tab 	1	 \tab 42.0253 \tab 	-93.6747 \tab 	0.001 \tab FALSE	\tab US/CENTRAL \tab NULL\cr
#'  Cedar	\tab Cedar_Cottage \tab 	puc	\tab 3471	\tab 40.6566 \tab 	-74.328	\tab 0.001	\tab FALSE \tab 	US/EASTERN	\tab Cedar Cottage \cr
#'  NSW		\tab NSW	\tab 	bw		\tab 4376	\tab 	-33.6919	\tab 	150.5283	\tab 	0.01		\tab FALSE	\tab 	Australia/NSW		\tab BirdNET-Pi - Faulconbridge, NSW, Australia \cr
#' }
#'
#'
#' @importFrom utils read.csv
#'
#' @return Dataframe containing listening staton parameters
#' @export
#'
# #'@seealso
# #' - [bb_stns_stnm()]
# #' - [bb_stns_id()]
#'
#' @param stnf path to stations database file
#' @param myparms Parameter list
#'
#' @examples
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' stns_db(stnf=mystns)
stns_db_p <- function(myparms,stnf=""){
  if(stnf=="")stnf=myparms$mystnsf
  # thestns=paste(stnsroot,sbfldr,"stations.csv",sep="/")
  if (file.exists(stnf)){
    bbstns  <- read.csv(stnf)
    return(bbstns)
  } else {   print(paste("The station database file was not found: ",stnf))
    print("Set working directory so that the file is available")
    print("See help for '?stns_db' to learn how to set up the stations file")
  }
  return(0)
}
