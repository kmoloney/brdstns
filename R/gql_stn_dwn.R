
# stnid=3471 #Cedar
# stnid=4376 #NSW
# stnid=27168 #neighboring PUC


#' Download bird listening station information
#'
#' The download is done from the [Birdweather.com](https://birdweather.com) database files using GraphQL.
#'
#' @param stnid ID number of station determined by selecting the station from the Birdweather.com [map](https://app.birdweather.com) or the birdweather app on a phone or tablet.
#'
#' @returns Dataframe with one row containing station information
#' @export
#'
#' @importFrom ghql GraphqlClient Query
#' @importFrom jsonlite fromJSON
##'
#' @examples
#' ##---------------------------
#' ##--  PUC station information downloaded from birdweather.com
#' ##---------------------------
#' gql_stn_dwn(3471)->newStn
#' str(newStn)
#' ##---------------------------
#' ##-- BirdNET-Pi station downloaded from birdweather.com
#' ##---------------------------
#' gql_stn_dwn(4376)->newStn
#' str(newStn)
#'
#'
gql_stn_dwn<-function(stnid){
  link <- 'https://app.birdweather.com/graphql'
  mycon <- GraphqlClient$new(url = link)
  q_vars=gql_stn_argset(stnid)
  theq=gql_stn_q()
  myQ <- Query$new()$query('link', theq)
  try({mycon$exec(myQ$link, variables =q_vars)->result},silent=TRUE)->errorm
if(inherits(errorm, "try-error")){
  stop(paste("Birdweather does not recognize station ID: \"",stnid,"\" as a legitimate station id number",sep=""))
}
  fromJSON(result,flatten = F)->result
  #result |> #%>%
  #  fromJSON(flatten = F)
  if(result$data$station$type=="birdnetpi"){
    result$data$station$minConfidence=NA
    result$data$station$minProbability =NA
  }
  newframe<- as.data.frame(result$data$station)
#  gql_stn_dfset(newframe)
}
