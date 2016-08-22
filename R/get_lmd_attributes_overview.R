#' Get the availability of LMD data by country and year
#'
#' @return data frame
#' @export
#'
#' @examples
get_lmd_attributes_overview <- function() {
  read.csv(system.file("extdata/info/lucas_attributes.csv", 
                         package="lucas"),
             stringsAsFactors=FALSE)
}