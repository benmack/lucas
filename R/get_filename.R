#' Get default filenames used to store downloaded LMD data
#'
#' @param lmddir base directory
#' @param year the year of the LMD data
#' @param country the country code
#' @param type the data format, xls or shp
#'
#' @return the filename as character
#' @export
#'
#' @examples
get_filename <- function(lmddir, year, country, type="xls") {
  if (type=="xls") {
    pattern <- paste0(lmddir, "/%d/",
                      .get_lmd_fname("%s", "%d"))
    if (year==2006)
      pattern <- gsub(".xls", "_0.xls", pattern)
  } else if (type=="shp") {
    pattern <- paste0(lmddir, "/%d/",
                      .get_lmd_fname("%s", "%d", ext="shp"))
  } else {
    stop("type should be xls or shp.")
  }
  return(sprintf(pattern, year, country, year))
}
