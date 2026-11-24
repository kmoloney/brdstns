
#' Add station using parameter list
#'
#' @param myparms Parameter list
#' @param myStation Full name for station if differs from myparms$mysn
#'
#' @importFrom utils menu
#'
#' @returns Parameter list
#' @export
#'
#' @examples
#'
# #' myparms<-stns_plst_set(mystnkey="NSWo",mysrc="bw",myid=2395)
# #' stns_stn_addp(myparms,myStation="Faulconbridge")
stns_stn_addp<-function(myparms,myStation=""){
stns_stn_add(myparms$mystnkey,myparms$mysrc,myparms$myid,mystation=myStation,stnf=myparms$mystnsf,root=myparms$myroot)
  }



#' Add a new station to stations database file
#'
#' @param myid ID obtained from birdweather.com if the source is "puc" or "bw". An id number will be added automatically for a "pi" station.
#' @param mysrc station type for data, i.e., "puc", "bw" or "pi"
#' @param mykey station key which is used to pull the full station name from the "stations.csv" file. Usually station name or shortened station name. See 'stns_stnm_p()' for details.
#' @param mystation Full name of station. Default is ' *mystation*="" ' which sets full name of station to *mykey*
#' @param stnf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#' @param root Root directory for saving data, default is 'Aviary' and should be kept in most cases.
#'
#'
#'
#' @returns
#' @export
#'
#' @examples
#'
#' mystns=system.file("extdata/stations.csv", package = "brdstns")
#'
#' stns_stn_add("Cedar0","puc",2395,stnf=mystns)
stns_stn_add<-function(mykey,mysrc,myid=0,mystation="",stnf="",root=""){
 newOK=TRUE
 newDB=FALSE
##-------
##-- check to see if station already exists in database
##-------
 if(stns_chk_db(stnsf=stnf)){ ### NOTE: need to add checks for NAME when pi and bw overlap if updating pi
    if(stns_chk_stnkey(mykey,stnsf=stnf)) {newOK=FALSE; print("Station KEY already exists in database")}
    if(stns_chk_id(myid,stnsf=stnf)) {newOK=FALSE; print("Station ID number already exists in database")}
    }
 if(!stns_chk_src(mysrc)) newOK=FALSE
 if(!newOK)return(0)
 ##-------
 ##-- create new station entries
 ##-------
  if(mysrc=="puc" || mysrc=="bw") {
   gql_stn_add(mykey,mysrc,myid,mystation,stnsf=stnf)->newstation
 }
  if(mysrc=="pi"){
    sql_stn_add(mykey,mysrc,myid,mystation,stnsf=stnf)->newstation
  }
 ##-------
 ##-- add new stations to stations.csv database
 ##-------
 mydbp=stns_fp(stnsf=stnf,root)
 if(!stns_chk_db(stnsf=stnf)){
   mytitle=
     choice <- menu(c("Yes", "No"), title = paste("Create new stations.csv file at:",stns_fp(stnsf=stnf),"?"))
   if(choice==1)newDB=TRUE
   if(choice==2){
     return(0)
   }
   dfdummy=stns_dfdummy()
   utils::write.csv(dfdummy[0,],stnf, row.names = FALSE)
   rm(dfdummy)
 }
if(!newDB){
 mystndb= stns_db(mydbp)
 newstation= rbind(mystndb,newstation)
}
 utils::write.csv(newstation,mydbp, row.names = FALSE)
 ##-------
 ##-- create folder structure for data downloads
 ##-------
  stns_dirset(newstation,root)
savestation=newstation
  }

