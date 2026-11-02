#library(lutz)
#library(lubridate)

#' Corrects time in downloaded Birdweather data
#'
#' Correction is required to adjust for local time of detections vs UTC time reported
#'
#' @param dtfrm Data frame containing downloaded Birdweather data
#'
#' @importFrom lutz tz_lookup_coords
#' @importFrom lubridate with_tz ymd_hms
#'
#'
#' @returns Data frame of raw download with corrected time stamp
#'
#' @examples
grphql_tm_crrct<-function(dtfrm)
{
  #  dtfrm = testData
  TZone = tz_lookup_coords(dtfrm$Latitude, dtfrm$Longitude,
                           method = "accurate")
  Time_utc=ymd_hms(dtfrm$Timestamp)
  Time_lcl<-rep(NA,nrow(dtfrm))
  for(i in 1:nrow(dtfrm)){
    x=format(Time_utc[i] ,format = "%Y-%m-%dT%H:%M:%S%z")
    y=with_tz(ymd_hms(x),tzone =TZone[i])
    #    z=format(y ,format = "%Y-%m-%dT%H:%M:%S%z")
    Time_lcl[i]=format(y ,format = "%Y-%m-%dT%H:%M:%S%z")
  }
  dtfrm$Timestamp_orig=dtfrm$Timestamp
  dtfrm$Timestamp=Time_lcl
  return(dtfrm)
}
