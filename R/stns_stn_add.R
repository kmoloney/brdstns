
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
# #' myparms<-stns_plst_set(mystn="NSW",mysrc="bw",myid=2395)
# #' stns_stn_addp(myparms,myStation="Faulconbridge")
stns_stn_addp<-function(myparms,myStation=""){
stns_stn_add(myparms$mystn,myparms$mysrc,myparms$myid,mystation=myStation,stnf=myparms$mystnsf,root=myparms$myroot)
  }



#' Add a new station to stations database file
#'
#' @param myid ID obtained from birdweather.com
#' @param mysrc station type for data, i.e., "puc", "bw" or "pi"
#' @param mykey station key which is used to pull the full station name from the "stations.csv" file. Usually station name or shortened station name. See 'stns_stnm()' for details.
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
 if(stns_chk_db(stnf)){
    if(stns_chk_key(mykey,stnf)) {newOK=FALSE; print("Station KEY already exists in database")}
    if(stns_chk_id(myid,stnf)) {newOK=FALSE; print("Station ID number already exists in database")}
    }
 if(!stns_chk_src(mysrc)) newOK=FALSE
 if(!newOK)return(0)
 ##-------
 ##-- create new station entries
 ##-------
  if(mysrc=="puc" || mysrc=="bw") {
   gql_stn_add(mykey,mysrc,myid,mystation,stnf)->newstation
 }
  if(mysrc=="pi"){
    sql_stn_add(mykey,mysrc,myid,mystation,stnf)->newstation
  }
 ##-------
 ##-- add new stations to stations.csv database
 ##-------
 mydbp=stns_fp(stnf,root)
 if(!stns_chk_db(stnf)){
   mytitle=
     choice <- menu(c("Yes", "No"), title = paste("Create new stations.csv file at:",stns_fp(stnf=stnf),"?"))
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

