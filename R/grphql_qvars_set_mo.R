
###-- Set variables to return month of data
###----
#' Set variables for call to GraphQL
#'
#'  Wrapper for general GraphQL download function 'bw_grphql_qvars_set()' to select for one month of data.
#'  Month is padded by one day on either side to allow for time corrections adjusting for timezone differences in timestamps
#'
#' @param yr Year of data to obtain
#' @param mo  Month of data to obtain
#' @param stns Station(s) id for obtiining data
#' @importFrom lubridate date
#' @seealso
#' - [grphql_qvars_set()]
# #' - [bw_grphql_tm_crrct()]
#'
#' @returns Variable list for making query
#'
#' @examples
grphql_qvars_set_mo<-function(yr,mo,stns){


  first_d=paste(yr,moStr(mo),"01",sep="-")
  last_d=paste(yr,moStr(mo+1),"01",sep="-")
  if(mo==12){
    last_d= date(paste(yr,moStr(mo),"31",sep="-"))+1
  } else {
    last_d=paste(yr,moStr(mo+1),"01",sep="-")
  }
  first_d=as.character(date(first_d)-1)
  return(grphql_qvars_set(first_d,last_d,stns))
}
