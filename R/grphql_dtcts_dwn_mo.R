#' Download one month of detection data from online GraphQL databases
#'
#' Downloads data from Birdweather.com databases for BirdNET-Pi and PUC stations
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download.
#' Required parameters in list are "station name", "station source", "Year" and "Month". See 'bw_plst_set()' for more information.
#'
#'
#'@seealso
#' -  [stns_plst_set()]
#'
#' @return  Dataframe with retreived monthly data
#' @export
#'
#' @examples
#'
#' myparms=stns_plst_set(mystn = "Munn", mysrc ="pi",myyr=2026,mymo=11)
#'
#'
grphql_dtcts_dwn_mo<-function(myparms){
  #myStations=c(stns_id(myparms$mystn,myparms$mysrc)[1])
  myStations=c(stns_id_p(myparms)[1])
  q_vars=grphql_qvars_set_mo(myparms$myyr,myparms$mymo,myStations)
  print("Downloading data from Birdweather...")
  grphql_dtcts_dwn(vars=q_vars) -> myBirds
  print("Correcting Birdweather timestamps...")
  myparms$brdfrm=myBirds= grphql_tm_crrct(myBirds)

  myparms$brdfrm=slct_dts(myparms)
  return(myparms)
}

