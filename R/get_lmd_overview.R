#' Get the availability of LMD data by country and year
#'
#' @return data frame
#' @export
#'
#' @examples
get_lmd_overview <- function() {
  read.csv(system.file("extdata/info/available_lmd.csv", 
                         package="lucas"),
             stringsAsFactors=FALSE)
}