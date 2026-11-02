
###----
#' Sets dataframe column names to correct values and modifies Timestamp to work correctly
#'
#' @param testT Data frome to adjust to correct column headrs and timestamp format for brdbrain data
#'
#' @returns Corrected dataframe
#' @export
#'
#' @examples
grphql_dtcts_mod<-function(testT){
  myBirds <- data.frame(
    Timestamp=testT$timestamp,
    Common.Name=testT$species$commonName,
    Scientific.Name=testT$species$scientificName,
    Latitude=testT$coords$lat,
    Longitude=testT$coords$lon,
    Station=testT$station$name,
    Station.id=testT$station$id,
    Score=testT$score,
    Confidence=testT$confidence,
    Probability=testT$probability,
    Mode=testT$mode
  )

  #### Fix GraphQL timestamp for processing; the form produced does not covert to proper local time but fixes problem not being able to process at all
  #  myBirds$Timestamp=gsub("T", " ", myBirds$Timestamp[])
  # myBirds$Timestamp=gsub("\\+"," +",myBirds$Timestamp[])
  #  myBirds$Timestamp=gsub("\\-"," -",myBirds$Timestamp[])
  #### Fix GraphQL END
  #myText=myBirds$Timestamp[]
  # myBirds$Timestamp<- substr(myBirds$Timestamp[], 1, nchar(myBirds$Timestamp[])-6)
  return(myBirds)
}
