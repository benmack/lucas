#' Get column names of the transect attributes
#'
#' @param x a LMD data frame 
#'
#' @return character vector with the transect names
#' @export
colnames_transect <- function(x) {
  cnames <- colnames(x)[grep("^TR[0-9]", colnames(x))]
  return(cnames)
  }