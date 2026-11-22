
#' Performs a GraphQL query on the birdweather.com databases
#'
#' Detections are downloaded over a series of dates determined by the 'vars' passed as an argument
#'
#' @param vars Variables for extracting detections from the online birdweather.com databases.
#' Can be set via the 'bw_grphql_qvars_set()' function. Values for "start date", "end date" and "station id" are expected.
#' Station ID is specific to the listening device as registered in the birdweather.com database.
#'
#' @importFrom ghql GraphqlClient Query
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @returns dataframe of downlaoded data
#'
#' @seealso
#' - [grphql_qvars_set()]
#' - [stns_id()] - for more info on station ids
#' @export
#'
#' @examples
grphql_dtcts_dwn<-function(vars=""){
  ####-- queries
  ###----
  q_detects_first<-'query Detections($stationIds: [ID!], $startd: ISO8601Date, $endd: ISO8601Date
) {
   detections(
     stationIds: $stationIds
     period: { from: $startd, to: $endd, timezone: "UTC" }
     classifications: "avian"
   ) {
     speciesCount
     totalCount
     nodes {
      timestamp
      species {
         commonName
         scientificName
         }
       coords {
         lat
         lon
         }
       station {
         id
         name
         }
       score
       confidence
       probability
       mode
     }
     pageInfo {
       endCursor
       hasNextPage
     }
   }
 }
'
  q_detects_iter<-'query Detections($stationIds: [ID!], $startd: ISO8601Date, $endd: ISO8601Date,$cafter: String
) {
   detections(
     stationIds: $stationIds
     period: { from: $startd, to: $endd, timezone: "UTC" }
     after: $cafter
      classifications: "avian"
   ) {
     speciesCount
     totalCount
     nodes {
      timestamp
      species {
         commonName
         scientificName
         }
       coords {
         lat
         lon
         }
       station {
         id
         name
         }
       score
       confidence
       probability
       mode
     }
     pageInfo {
       endCursor
       hasNextPage
     }
   }
 }
'
  ###----
  ###---- Intiate connection
  ###----
  link <- 'https://app.birdweather.com/graphql'
  mycon <- GraphqlClient$new(url = link)
  q_vars=vars
  ###----
  ###--- Grab first page of data and setup to grab following pages
  ###----
  myQ <- Query$new()$query('link', q_detects_first)
  result <- mycon$exec(myQ$link, variables =q_vars) |> #%>%
    fromJSON(flatten = F)
  result$data$detections$nodes  |> #%>%
    as_tibble() ->testT
  ###----Get ready for loop to read all pages for date range
  nwPage=result$data$detection$pageInfo$hasNextPage
  myQ<- Query$new()$query('link', q_detects_iter)
  pgnm=1
  ###----
  ###---- Loop through pages
  while(isTRUE(nwPage)){
    q_vars$cafter=result$data$detection$pageInfo$endCursor
    result <- mycon$exec(myQ$link, variables = q_vars) |> #%>%
      fromJSON(flatten = F)
    result$data$detections$nodes  |> #%>%
      as_tibble() ->answersI
    testT=
      rbind(testT,answersI[1:nrow(answersI),])
    nwPage=result$data$detection$pageInfo$hasNextPage
    print(paste("Page:", pgnm))
    pgnm=pgnm+1

    #nwPage=result$data$detection$pageInfo$hasNextPage
  }
  ###----End loop
  print(paste("Page:", pgnm))



  myBirds<- grphql_dtcts_mod(testT)
  return(myBirds)
}
