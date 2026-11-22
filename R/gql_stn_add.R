#' Title
#'
#' @param mykey
#' @param mysrc
#' @param myid
#' @param mystation
#' @param mykey station key which is used to pull the full station name from the "stations.csv" file. Usually station name or shortened station name. See 'stns_stnm()' for details.
#' @param mysrc station type for data, i.e., "puc", "bw" or "pi"
#' @param myid ID obtained from birdweather.com
#' @param mystation Full name of station. Default is ' *mystation*="" ' which sets full name of station to *mykey*
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns
#' @export
#'
#' @examples
gql_stn_add<-function(mykey,mysrc,myid,mystation="", stnf=""){
  gql_stn_dwn(myid) |> gql_stn_dfset() -> newstation
  if(!mystation=="")newstation$Station=gsub(" ", "_", mystation, fixed = TRUE)
 # gsub(" ", "_", theStation, fixed = TRUE)
  newstation$Stn_key=mykey
  if(mysrc=="puc" & newstation$Src=="bw"){
    mysrc="bw"
    warning("Note: Station is \"bw\" not \"puc\".\nNote:Station source was set to \"bw\" \n")
  }
  if(mysrc=="bw"){
    newstation2=newstation
    newstation2$Src="pi"
    newstation2$id=stns_id_newpi_set(stnf=stnf)
    newstation2$Bw_name=NA
    newstation=rbind(newstation2,newstation)
  }
  newstation
  }
