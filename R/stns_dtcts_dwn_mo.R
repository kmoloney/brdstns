
#' Download a month of listening station data
#'
#' Calls functions to query PUC or BirdNET-Pi database for one month of data
#'
#' @param myparms Parameter list for selecting station, data src, year and month for download
#'
#' @returns Parameter list with downloaded data attached
#'
#' @seealso
#' - [stns_plst_set()] for information on list structure and how to set 'myparms'
#' - [sqlite_dtcts_dwn_mo()] for downloading a month of data from native BirdNET-Pi databases
#' - [grphql_dtcts_dwn_mo()] for downloading a month of data from [Birdweather.com](https://birdweather.com) databases
#' @export
#'
#' @examples
stns_dtct_dwn_mo<-function(myparms){
  if(myparms$mysrc=="pi"){
    sqlite_dtcts_dwn_mo(myparms) ->myparms
  }
  if(myparms$mysrc=="bw" || myparms$mysrc=="puc") {
    grphql_dtcts_dwn_mo(myparms) ->myparms
  }
  return(myparms)
}
