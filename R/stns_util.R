###-----------------------
###-- Stns_dfdummy: Creates a dummy dataframe
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
    if(root=="")root=stnsroot
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

###-----------------------
###-- Stns_fp: Returns path to stations.csv
###-----------------------

#' Path to stations database file
#'
#' Sets and returns the path to the stations database file.  The default path is *'Aviary/brddat/staions.csv'*.
#'
#' @param stnsf User chosen path to stations database file. The default file path is *"Aviary/brddat/staions.csv"*. See 'stns_plst_set()' for more information
#' @param root User chosen root for the stations database file.  It produces the path path *'**root**/brddat/staions.csv'*
#'
#' @returns Path to stations database file.
#' @export
#'
#' @seealso [stns_plst_set()]
#'
#' @examples
#' stns_fp()
#' stns_fp(root="data")
#' stns_fp(stnsf="newdata/brddat/stations.csv")
stns_fp<-function(stnsf="",root=""){
  if(stnsf==""){
   if(root=="") stnsf=paste(stnsroot,"brddat/stations.csv",sep="/")
   if(root!="")stnsf=paste(root,"brddat/stations.csv",sep="/")
  }
  return(stnsf)
}


###-----------------------
###-- Stns_id_newpi_set: Utility function for incrementing id numbers for pi station data
###-----------------------

#' Get ID number for pi
#'
#' @returns old pi max id plus one
#'
#' @noRd
#'
stns_id_newpi_set<-function(stnsf=""){
  Src=NULL
  newstnum=1
  if( stns_chk_db(stnsf=stnsf)){
    mystns<-stns_db(stnsf=stnsf)
    ##-- increment pi station id by one
    mystns=subset(mystns,Src=="pi")
    newstnum=max(mystns$id)+1
  }
  #  print(newstnum)
  newstnum=newstnum
}

###-----------------------
###-- Stns_stnm_p: Extracts a full station name using parameter list
###-----------------------

#' Get full station name using parameter list as argument
#'
#' Extracts a full station name from a locally stored "station.csv" database file using values for the key ('*Stn_key*') and src ('*Src*') associated with the unique station
#'
#' @param myparms  List containing station parameters set with 'bw_parmlist()'
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'@seealso
#' - [stns_db()] for information on the variables in the stations database file.
#' - [stns_plst_set()] for information on the parameter list ('myparms') argument
#' - [stns_stnm()] which produces the same output as *'stns_stnm_p()'* but does not use a parameter list as an argument
#' @returns Full station name: the '*Station*' variable in the 'stations.csv' database
#' @export
#'
#' @examples
#' ##----------------------------
#' ##---- set up parameters for function call
#' ##----------------------------
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' myparms=stns_plst_set("Cedar","puc")
#' str(myparms)
#' ##----------------------------
#' ##---- station entry found in stations database
#' ##----------------------------
#' stns_stnm_p(myparms,stnsf=mystns)
#' ##----------------------------
#' ##---- The stations database file is not found
#' ##----------------------------
#' stns_stnm_p(myparms,stnsf="dummy")
#' ##----------------------------
#' ##---- station entry not found in stations database
#' ##----------------------------
#' myparms=stns_plst_set("Cedars","puc")
#' stns_stnm_p(myparms,stnsf=mystns)
#'
stns_stnm_p <- function(myparms,stnsf=""){
  if(stnsf=="")stnsf=myparms$mystnsf
  if(file.exists(stnsf)){
    if(stns_chk_stnp(myparms,stnsf)){
      tmpStns<-stns_db_p(myparms,stnsf)
      thestation=tmpStns$Station[tmpStns$Stn_key==myparms$mystnkey & tmpStns$Src==myparms$mysrc]
    } else {
      thestation=myparms$mystnkey
      print(paste("Station not found in stations file \'",stnsf,"\'",sep=""))
      print(paste("Setting station name to \"" ,myparms$mystnkey , "\" using 'myparms$Stn_key' ",sep=""), quote = FALSE)
      return(thestation)
    }
    return(thestation[1])
  } else {
    print(paste("Station file \'",stnsf, "\' not found. ",sep=""), quote = FALSE)
    print(paste("Setting station name to \"",myparms$mystnkey, "\" using the station key value 'myparms$mystnkey' ",sep=""), quote = FALSE)
    return(myparms$mystnkey)
  }
}

###-----------------------
###-- Stns_stnm: Extracts a full station name using individual arguments
###-----------------------

#' Get full station name
#'
#' Extracts a full station name from a locally stored "station.csv" database file using values for the key ('*Stn_key*') and src ('*Src*') associated with the unique station
#'
#'
#' @param mystnkey Short station name ('Stn_key' in stations database)
#' @param mysrc Station src which can be "puc", "bw" or "pi"
#' @param myroot Root directory below which all output is stored. The default value is "Aviary"
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns Full station name: the '*Station*' variable in the 'stations.csv' database
#' @export
#'
#' @seealso
#' - [stns_stnm_p()] which produces the same output as *'stns_stnm_p()'* but uses a parameter list as an argument
#' - [stns_db()] for information on the variables in the stations database file.
#'
#' @examples
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#' stns_stnm("Cedar","puc",stnsf=mystns)
#' stns_stnm("XX","puc",stnsf=mystns)
#' stns_stnm("Cedar","bw",stnsf=mystns)
stns_stnm<-function(mystnkey,mysrc,myroot="",stnsf=""){
  myparms=stns_plst_set(mystnkey = mystnkey,mysrc = mysrc,myroot = myroot,mystnsf = stnsf)
  stns_stnm_p(myparms)
}

