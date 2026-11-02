
#' Set parameters for processing data with brdbrain
#'
#' `stns_plst_set()` constructs a list of parameters to pass to brdbrain routines
#'
#'
#' @param mystn Short station name ('Stn_key' in stations database)
#' @param mysrc Station src which can be "puc", "bw" or "pi"
#' @param myyr Year of data to process
#' @param mymo Month of data to process
#' @param brdfrm Brdbrain dataframe for further analysis, usually populated internally by functions
#'
# #' @seealso Functions using stns_parmlist as an argument:
# #' - [bb_db_mo_add()]
# #' - [bw_dwn_mo()]
# #' - [bw_dwn_to_arch_mo()]
# #' - [bw_sqlite_dtcts_dwn_mo()]
# #' - [bw_grphql_dtcts_dwn_mo()]
#'
#'
#' @returns List containing parameters for brdstns routines
#' @export
#'
#' @examples
#' myparms<-stns_plst_set("Munn","pi",2026,9)
#' str(myparms)
stns_plst_set<-function(mystn,
                     mysrc,
                     myyr,
                     mymo,
                     brdfrm=NULL){
  mydat=list(mystn = mystn,
             mysrc =mysrc,
             myyr=myyr,
             mymo=mymo,
             brdfrm=brdfrm,
             bbdat=FALSE,
             ltype="stns")

  return(mydat)
}
