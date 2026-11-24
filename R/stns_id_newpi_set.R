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
