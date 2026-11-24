
###-----------------------
###-- Stns_chk_id: Check to see if ID exists in stations.csv
###-----------------------

#' Check if a specific station ID exists
#'
#' Check to see if a specific station ID exists in the *'stations.csv'* database file
#'
#' @param myid Station ID to check
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See *'stns_plst_set()'* for more information
#'
#' @returns Boolean - TRUE if *'myid'* is found in the stations database file, FALSE if not.
#' @export
#'
#' @seealso
#' - [stns_db()]
#'
#'
#' @examples
#' stns_chk_id(1)
#' stns_chk_id(-10)
stns_chk_id<-function(myid,stnsf=""){
  if(stns_chk_db(stnsf=stnsf)){
    tmpStns<-stns_db(stnsf=stnsf)
    myid %in% tmpStns$id
    if(myid %in% tmpStns$id){
  #     print("Station ID number already exists in database")
       return(TRUE)
    }
  }
  return(FALSE)
}

###-----------------------
###-- Stns_chk_key: Check to see if station KEY exists in stations.csv
###-----------------------

#' Check if station key exists in stations database
#'
#' Check to see if a specific station key exists in the *'stations.csv'* database file
#'
#' @param mykey Stn_key to check in the *'stations.csv'* database file. See *'stns_db()'* for more information.
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See *'stns_plst_set()'* for more information
#'
#' @seealso
#' - [stns_db()]
#' - [stns_plst_set()]
#'
#'
#' @returns Boolean
#' @export
#'
#' @examples
#' stns_chk_stnkey("Munn")
#' stns_chk_stnkey("XXX")
stns_chk_stnkey<-function(mykey,stnsf=""){
  if(stns_chk_db(stnsf=stnsf)){
    tmpStns<-stns_db(stnsf=stnsf)
    if( mykey %in% tmpStns$Stn_key){
    #  print("Station key already exists in database")
      return(TRUE)
    }
  }
  return(FALSE)
}

###-----------------------
###-- Stns_chk_src: Check to see if station SRC is acceptable
###-----------------------

#' Check if station source is acceptable
#'
#' Acceptable station station sources are "puc","bw" or "pi".  Not available outside of package.
#'
#' @param mysrc Source of data
#'
#' @returns Boolean
#'
#' @noRd
#'
#' @examples
#' stns_chk_src("pi")
#' stns_chk_src("xx")
stns_chk_src<-function(mysrc){
  if(!(mysrc=="puc" || mysrc=="bw" || mysrc=="pi" )){
    cat('Source must be set to "puc","bw" or "pi" \n  ')
    return(FALSE)
  }
  return(TRUE)
}

###-----------------------
###-- Stns_chk_db: Check to see if the Stations.csv FILE is found
###-----------------------

#' Check for stations database file
#'
#' Checks to determine if the stations database file exists. Default is to check *'Aviary/brddat/stations.csv'*
#'
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'
#' @returns Boolean TRUE if the station is found, FALSE if not.
#' @export
#'
#' @examples
#' stns_chk_db()
#' stns_chk_db(stnsf="data/brddat/stations.csv")
#' stns_chk_db("xx")
stns_chk_db<-function(stnsf=""){
  if(stnsf=="")stnsf=paste(stnsroot,"brddat/stations.csv",sep="/")
  if (file.exists(stnsf)){
    return(TRUE)
  }
  print(paste("Station file",stnsf,"was not found"))
  return(FALSE)
}


###-----------------------
###-- Stns_chk_stnp: Check to see if the STATION with station KEY and station SOURCE exits.
###-----------------------


#' Test for station entry in stations database
#'
#' Tests for station's existence in *'stations.csv'* based on a specific combination of a station's key value *'mystnkey'* and source *'mysrc'*. It is a wrapper for the *'stns_chk_stn()'* fucntion that doesn't use a parmeter list as an argument.
#'
#' @param myparms List of parameter values to determine if a specific station is in *'stations.csv'* the stations database file. Necessary parameter values are a station's key value *'mystnkey'* and source *'mysrc'*.
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'@seealso
#' - [stns_chk_stn()] is the same function using simple arguments instead of a list of parameters.
#' - [stns_plst_set()] for information on the parameter list ('myparms') argument
#' - [stns_db()] for information on the variables in the stations database file.
#'
#' @returns Logical TRUE if entry exists in 'stations.csv' database and FALSE if doesn't.
#' @export
#'
#' @examples
#' myfile <- system.file("extdata/stations.csv", package = "brdstns")
#' myparms<-stns_plst_set("Cedar","puc")
#' str(myparms)
#' stns_chk_stnp(myparms,stnsf=myfile)
#' myparms$mystnkey="XXX"
#' stns_chk_stnp(myparms,stnsf=myfile)
stns_chk_stnp<-function(myparms,stnsf=""){
  stns_chk_stn(myparms$mystnkey,myparms$mysrc,stnsf=stnsf)
}

#' Test for station entry in stations database
#'
#' Tests for station's existence in *'stations.csv'* based on a specific combination of a station's key value *'mystnkey'* and source *'mysrc'*.
#'
#' @param mystnkey station key which is a short name used to identify a specific bird song listening station.
#' @param mysrc station source which is source providing a bird listening station's downloaded data. This can be "puc","bw" or "pi".
#' @param stnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns Logical TRUE if entry exists in 'stations.csv' database and FALSE if doesn't.
#' @export
#'
#'@seealso
#' - [stns_plst_set()] for information on the parameter list ('myparms') argument
#' - [stns_db()] for information on the variables in the stations database file.
#' - [stns_chk_stnp()] which provides a wrapper for this function using a parameter list as an argument.
#' @examples
#' myfile <- system.file("extdata/stations.csv", package = "brdstns")
#' stns_chk_stn("Cedar","puc",stnsf=myfile)
#' stns_chk_stn("XXX","puc",stnsf=myfile)
#' stns_chk_stn("Cedar","XXX",stnsf=myfile)
#' stns_chk_stn("Cedar","puc",stnsf="XXX")
#'
stns_chk_stn<-function(mystnkey,mysrc,stnsf=""){
  if(stns_chk_db(stnsf=stnsf)){
    tmpStns<-stns_db(stnsf=stnsf)
    if(nrow(tmpStns[tmpStns$Stn_key==mystnkey & tmpStns$Src==mysrc,])){
       return(TRUE)
    }
  }
 return(FALSE)
}
