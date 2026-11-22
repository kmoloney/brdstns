
###-----------------------
###-- Stns_chk_id: Check to see if ID exists in stations.csv
###-----------------------

#' Check if station id exists in stations database
#'
#' @param myid ID to check
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns Boolean
#' @export
#'
#' @examples
#' stns_chk_id(1)
#' stns_chk_id(-10)
stns_chk_id<-function(myid,stnf=""){
  if(stns_chk_db(stnf)){
    tmpStns<-stns_db(stnf)
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
#' @param mykey Stn_key to check
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns Boolean
#' @export
#'
#' @examples
#' stns_chk_key("Munn")
#' stns_chk_key("XXX")
stns_chk_key<-function(mykey,stnf=""){
  if(stns_chk_db(stnf)){
    tmpStns<-stns_db(stnf)
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
#' Acceptable station station sources are "puc","bw" or "pi"
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

#' Check if stations database file exists
#'
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'
#' @returns Boolean
#' @export
#'
#' @examples
#' stns_chk_db()
#' stns_chk_db(stnf=paste(brdstns::stnsroot,"brddat/stations.csv",sep="/"))
#' stns_chk_db("xx")
stns_chk_db<-function(stnf=""){
  if(stnf=="")stnf=paste(stnsroot,"brddat/stations.csv",sep="/")
  if (file.exists(stnf)){
    return(TRUE)
  }
  print(paste("Station file",stnf,"was not found"))
  return(FALSE)
}


###-----------------------
###-- Stns_chk_stnp: Check to see if the STATION with station KEY and station SOURCE exits.
###-----------------------


#' Test for station entry in stations database
#'
#' This function is mainly provided as a tool for use in internal functions.
#'
#' @param myparms List of parameter values to determine station, src and timeframe of data to download. Required parameters are:
#'  - *myparms$mystn:* station key which is used to pull the full station name from the "stations.csv" file. See 'stns_stnm()' for details.
#'  - *myparms$mysrc:* station type for data, i.e., "puc", "bw" or "pi"
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#'@seealso
#' - [stns_db()] for information on the variables in the stations database file.
#' - [stns_plst_set()] for information on the parameter list ('myparms') argument
#'
#' @returns Logical TRUE if entry exists in 'stations.csv' database and FALSE if doesn't
#' @export
#'
#' @examples
#' myfile <- system.file("extdata/stations.csv", package = "brdstns")
#' myparms<-stns_plst_set("Cedar","puc")
#' str(myparms)
#' stns_chk_stnp(myparms,stnf=myfile)
#' myparms$mystn="XXX"
#' stns_chk_stnp(myparms,stnf=myfile)
stns_chk_stnp<-function(myparms,stnf=""){
  stns_chk_stn(myparms$mystn,myparms$mysrc,stnf=stnf)
  # if(stns_chk_db(stnf)){
  #   tmpStns<-stns_db_p(myparms,stnf)
  #   mystn=tmpStns$Station[tmpStns$Stn_key==myparms$mystn & tmpStns$Src==myparms$mysrc]
  #   if(identical(nzchar(mystn), logical(0))){
  #       return(FALSE)
  #       }
  #   return(TRUE)
  #   }
  # return(FALSE)
}

#' Check if station exists for stnkey value and station source type
#'
#' @param mystn station key
#' @param mysrc station source
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#'
#' @returns
#' @export
#'
#' @examples
stns_chk_stn<-function(mystn,mysrc,stnf=""){
  if(stns_chk_db(stnf)){
    tmpStns<-stns_db(stnf)
    if(nrow(tmpStns[tmpStns$Stn_key==mystn & tmpStns$Src==mysrc,])){
       return(TRUE)
    }
  }
 return(FALSE)
}
