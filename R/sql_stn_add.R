#' Get SQLite station info from db file
#'
#' @param mykey station key which is used to pull the full station name from the "stations.csv" file. Usually station name or shortened station name. See 'stns_stnm()' for details.
#' @param myid ID obtained from birdweather.com
#' @param mysrc station type for data, i.e., "puc", "bw" or "pi"
#' @param mystation Full name of station. Default is ' *mystation*="" ' which sets full name of station to *mykey*
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @importFrom lutz tz_lookup_coords
#' @importFrom DBI dbGetQuery
#' @importFrom tidygeocoder reverse_geocode
#'
#' @returns
#' @export
#'
#' @examples
sql_stn_add<-function(mykey,mysrc,myid,mystation="",stnf=""){
  newstation=NA
  lat=NULL
  lon=NULL
  con <- dbConnect(SQLite(), file.choose() )
dwnstation <- dbGetQuery(con, "SELECT * FROM detections LIMIT 1")
dbDisconnect(con)
rm(con)
sql_stn_dfset(dwnstation)->tmpstation

gps_data <- data.frame(
  lon = c(tmpstation$Lon),
  lat = c(tmpstation$Lat)
)
results <- reverse_geocode(
  gps_data,
  lat = lat,
  long = lon,
  method = "arcgis",
  full_results = TRUE
)
if(mystation=="")mystation=mykey
mycont=NA
if(results$CountryCode=="USA")mycont="North America"
if(results$CountryCode=="AUS")mycont="Oceania"


tmpstation$Stn_key   = mykey
tmpstation$Station   = mystation
tmpstation$id        = stns_id_newpi_set(stnf="")
tmpstation$TZone     = tz_lookup_coords(tmpstation$Lat, tmpstation$Lon, method = "accurate")
tmpstation$state     = results$Region
tmpstation$country   = results$CntryName
tmpstation$continent = mycont

tmpstation

}
