#' Set arguments for graphQL query for individual station data
#'
#' @param stnid Id number of the station from birdweather.com
#'
#' @returns variables for station query
#' @noRd
#' @examples
gql_stn_argset<-function(stnid){
  vars=list(id=stnid)
}
