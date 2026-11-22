
#' Query for obtaining station data from birdweather.com
#' @noRd
#' @returns
#'
gql_stn_q<-function(){
  myq='query station($id: ID!) {
  station(id: $id) {
    continent
    country
    earliestDetectionAt
    hasProbabilities
    id
    latestDetectionAt
    locationPrivacyRadius
    minConfidence
    minProbability
    name
    portableDetections
    state
    timezone
    type
    coords {
      lat
      lon
    }
    locationPrivacy
  }
}'
}
