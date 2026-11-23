
#' Create a list of arguments for downloading data for bird listening stations
#'
#' `stns_plst_set()` constructs a list of parameters to pass to brdstns routines for downloading data directly from
#' Birdnet-Pi database files (*mysrc*="pi"), or from data stored at app.birdweather.com
#' for Birdnet-Pi stations (*mysrc*="bw") or puc stations (*mysrc*="puc")
#'
#'
#' @param mystn Short station name ('Stn_key' in stations database)
#' @param mysrc Station src which can be "puc", "bw" or "pi" ('Src' in stations database)
#' @param myid Unique id number for station.  Puc and bw ids are provided by birdweather.com. The brdstns package will automatically produce an id when a new station is added.
#' @param myyr Year of data to process, default is 0 but many routines will require a specific year to be entered.
#' @param mymo Month of data to process, default is 0 but some routines may require a specific year to be entered.
#' @param brdfrm Brdbrain dataframe for further analysis, usually populated internally after downloading data and used to pass data for further processing in other packages
#' @param myroot Root directory below which all output is stored. The package default value is "Aviary"
#' @param mystnsf Path to file holding listening station information. Setting this changes the path from the default file path. See 'stns_plst_set()' for more information
#' @param show Boolean with a default of FALSE.  Setting it to true prints out the list structure when the function is called
#'
#' @importFrom utils str
#'
#' @details
#'
#' #### Parameters in list not set directly through function arguments
#' - *mystnsf:* contains the path to the stations database file from the current working directory.  It is set to 'myroot/brddat/stations.csv' when the list is created.
#' - *bbdat:* boolean value set to FALSE indicating any dataframe pointed to by brdfrm is raw download data
#' - *ltype:* indicates the type of parameter list, in this case one used by the brdstns package and set to a value of *"stns"*
#'
# #' @seealso Functions using stns_parmlist as an argument:
# #' - [bb_db_mo_add()]
# #' - [bw_dwn_mo()]
# #' - [bw_dwn_to_arch_mo()]
# #' - [bw_sqlite_dtcts_dwn_mo()]
# #' - [bw_grphql_dtcts_dwn_mo()]
#'
#'
#'
#'
#' @returns List containing parameters for brdstns routines
#' @export
#'
#' @examples
#' myparms<-stns_plst_set("Munn","pi",myyr=2026,mymo=9)
#' str(myparms)
#' myparms<-stns_plst_set("Munn","pi",myyr=2026,mymo=9)
#' str(myparms)
#' myparms<-stns_plst_set("Munn","pi",myyr=2026,mymo=9,myroot="data")
#' str(myparms)
stns_plst_set<-function(mystn,
                     mysrc,
                     myid=0,
                     myyr=0,
                     mymo=0,
                     brdfrm=NULL,
                     myroot="",
                     mystnsf="",
                     show=FALSE){
 if(myroot=="")myroot=stnsroot
  mydat=list(mystn = mystn,
             mysrc =mysrc,
             myid=myid,
             myyr=myyr,
             mymo=mymo,
             brdfrm=brdfrm,
             myroot=myroot,
             mystnsf=stns_fp(stnf=mystnsf,myroot),
             bbdat=FALSE,
             ltype="stns")
if(show)utils::str(mydat)
  mydat=mydat
}
