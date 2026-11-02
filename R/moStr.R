
##-- returns string representing month for file name construction
#' bw_moStr converts an integer into a string of two digits representing a month
#'
#'
#' @param num_mo Integer between 1 and 12 representing a month
#'
#' @return Two character string representing a month
#' @noRd
#' @examples
#' moStr(3)
moStr <- function(num_mo){
  if(num_mo > 12 || num_mo < 1 || num_mo%%1 != 0){
    message("number an integer representing month")
    return(0)
  }
  mo =  c("01","02","03","04","05","06","07","08","09","10","11","12")
  return (mo[num_mo])
}
