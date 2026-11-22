#' Sets dataframe from downloaded station data
#'
#' @param mydwn Data for one station downloaded from birdweather.com
#'
#' @returns Station dataframe for one station
#' @noRd
gql_stn_dfset<-function(mydwn){
  if(mydwn$type=="birdnetpi"){
    mydwn$type="bw"
    theStation=sub("BirdNET-Pi - ", "", mydwn$name)
    theStation=gsub(" ", "_", theStation, fixed = TRUE)
  }
  if(mydwn$type=="puc"){
    theStation=gsub(" ", "_", mydwn$name, fixed = TRUE)
  }
  myStationOut<- data.frame(
    Stn_key = NA,
    Station = theStation,
    Src=mydwn$type,
    id=as.integer(mydwn$id),
    Lat= mydwn$coords.lat,
    Lon= mydwn$coords.lon,
    GeoF=0.1,
    substat=FALSE,
    TZone=mydwn$timezone,
    dtFirst=as.character(lubridate::date(mydwn$earliestDetectionAt)),
    dtLast=as.character(lubridate::date(mydwn$latestDetectionAt)),
    state=mydwn$state,
    country=mydwn$country,
    continent=mydwn$continent,
    Bw_name=mydwn$name
  )
}

