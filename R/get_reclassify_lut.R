#' Build-in look-up tables for reclassifying LUCAS classes  
#'
#' @param type LC1nC9 or LC1nC10
#'
#' @return data.frame with the look up tabe that can be passed to \code{\link{reclassify_LULC}}.
#' @export
#'
#' @examples
#' \dontrun{
#' get_reclassify_lut("LC1nC9")
#' }
get_reclassify_lut <- function(type="LC1nC9") {
  warning("For the year 2006 please use LC1nC9_2006 and LC1nC10_2006 since the LUCAS Codes for Woodland (C*) are different.")
  fn.lut <- system.file(paste0("extdata/reclassify_luts/", type,".txt"), package="lucas")
  lut <- read.table(fn.lut, header=TRUE, sep=",", stringsAsFactors = F)
  lut <- data.frame(lut, t(col2rgb(lut$color, alpha = FALSE)))
  return(lut)
}
