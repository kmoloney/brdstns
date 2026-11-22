###-----------------------
###-- stns_dfdummy: Creates a dummy dataframe
###-----------------------

#' Creates a dummy dataframe
#'
#' Used for initial setup of stations.csv file
#' Not exported
#' @returns dummy database
#' @noRd
#'
stns_dfdummy<-function(){
  newstation<- data.frame(
    Stn_key = NA,
    Station = NA,
    Src=NA,
    id= NA,
    Lat= NA,
    Lon= NA,
    GeoF=NA,
    substat=NA,
    TZone=NA,
    dtFirst=NA,
    dtLast=NA,
    state= NA,
    country=NA,
    continent=NA,
    Bw_name=NA
  )
}

###-----------------------
###-- stns_fp: Returns path to stations.csv
###-----------------------

#' Return path to stations database file
#'
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#' @param root Self chosen path to stations database file
#'
#' @returns
#' @export
#'
#' @examples
#' stns_fp()
#' stns_fp(root="data")
#' stns_fp(stnf="Aviary/brddat/stations.csv")
stns_fp<-function(stnf="",root=""){
  if(stnf==""){
   if(root=="") stnf=paste(brdstns::stnsroot,"brddat/stations.csv",sep="/")
   if(root!="")stnf=paste(root,"brddat/stations.csv",sep="/")
  }
  return(stnf)
}


###-----------------------
###-- Stns_dirset: Create new directories for stations added to stations.csv
###-----------------------

#' Creates directories for new stations added to stations.csv database
#'
#' @param mystns dataframe with new stations
#' @param root Root directory for saving data, default is 'Aviary' and should be kept in most cases.
#'
#' @noRd
stns_dirset<-function(mystns,root=""){
 newstation=mystns
   for(i in 1:nrow(newstation)){
    if(root=="")root=brdstns::stnsroot
    StationName=newstation$Station[i]
    mySrc=newstation$Src[i]
    newRoot=paste(root,StationName,sep="/")
    newRoot=paste(newRoot,paste(StationName,mySrc,sep="-"),sep="/")
    if(!(dir.exists(newRoot))){
      dir.create(file.path(newRoot),recursive = TRUE,showWarnings = FALSE)
      print(paste("New data directory created: ",newRoot,sep=""))
    }
  }
}
