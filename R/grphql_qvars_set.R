###- Set query variables
###----
#' Set variables for downloading detection data using GraphQL
#'
#' List is used as argument for 'grphql_dtcts_dwn()' to download detection data from Birdweather.com [map](https://app.birdweather.com)
#'
#' @param start String of start date for extracting data
#' @param end  String for ending date for extracting data
#' @param stns Station ID numbers on Birdweather
#'
#' @seealso
# #' - [bw_grphql_dtcts_dwn()]
#'
#' @returns  List of variables to feed to query
#' @export
#'
#' @examples
grphql_qvars_set<-function(start,end,stns){
  newVar<- list(
    startd=start,
    endd=end,
    stationIds =stns,
    cafter=""
  )
  return(newVar)
}
