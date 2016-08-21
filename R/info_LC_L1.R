#' Code and name of level 1 classes
#'
#' @return
#' @export
#'
#' @examples
info_LC_L1 <- function() {
  info <- data.frame("Code"=paste0(LETTERS[1:8], "00"),
                     "Description"=c(
                       "Artificial land",
                       "Cropland",
                       "Woodland",
                       "Shrubland", 
                       "Grassland", 
                       "Bare land and lichens/moss", 
                       "Water areas", 
                       "Wetlands" 
                     ))
  return(info)
}