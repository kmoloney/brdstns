#' Set dataframe for PI station
#'
#' @param mydwn Dataframe with one row downloaded from SQLite database for PI station
#'
#' @returns Paritally filled in station information
#' @noRd
#'
#'
sql_stn_dfset<-function(mydwn){
  newstation<- data.frame(
    Stn_key = NA,
    Station = NA,
    Src="pi",
    id= NA,
    Lat= mydwn$Lat,
    Lon= mydwn$Lon,
    GeoF=0.1,
    substat=FALSE,
    TZone=NA,
    dtFirst=lubridate::date(mydwn$Date),
    dtLast=NA,
    state= NA,
    country=NA,
    continent=NA,
    Bw_name=NA
  )
}
