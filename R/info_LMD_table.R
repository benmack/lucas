#' Print the description of a LUCAS attribute
#'
#' @param attr the attribute (see \code{\link{info_LMD_table_attributes}})
#' @param year the year of the LMD (so far only 2012 - attributes of other years migh differ)
#' @param print print the description? defaults to \code{TRUE}
#'
#' @return the information is returned invisible
#' @export
#'
#' @examples
info_LMD_table <- function(attr=NULL, year=2012, print=T) {
  if (year == 2012) {
    fname <- system.file("extdata/info/Contents-LUCAS-primary-data-12-20140618-.csv", package="lucas")
    lmd_data_description <- read.csv(fname, stringsAsFactors=F, sep=";", header=T)
  } else {
    stop("Description only available for the year 2012.")
  }
  if (! is.null(attr)) {
    lmd_data_description <- lmd_data_description[lmd_data_description$Label %in% attr, ]
  }
  
  if (print)
    for (i in 1:nrow(lmd_data_description)) {
      cat(paste0("\n************\n", 
                 paste(lmd_data_description[i, 1:3], collapse=" | ")))
      if (lmd_data_description[i, 4] != "") {
        cat(paste0("\nVALUES:\n\t", gsub("\n", "\n\t", lmd_data_description[i, 4])))
      }
    }
  invisible(lmd_data_description)
}

#' List the LMD attributes
#'
#' @param year the year of the LMD (so far only 2012 - attributes of other years migh differ)
#'
#' @return NULL
#' @export 
#'
#' @examples
info_LMD_table_attributes <- function(year=2012) {
  if (year == 2012) {
    fname <- system.file("extdata/info/Contents-LUCAS-primary-data-12-20140618-.csv", package="lucas")
    lmd_data_description <- read.csv(fname, stringsAsFactors=F, sep=";", header=T)
    labels <- lmd_data_description$Label
  }
    ans <- labels[1:which(labels=="TR1")]
    cat("LMD attributes:\n  -", paste0(ans, collapse="\n  - "), 
        "...", labels[length(labels)], "\n")
}

#' Print the description of a LMD attribute
#'
#' @param attr the attribute name (see \code{\link{info_LMD_table_attributes}})
#' @param year the year of the LMD (so far only 2012 - attributes of other years migh differ)
#'
#' @return the description (invisible)
#' @export
#'
#' @examples
print_attribute_info <- function(attr=NULL, year=2012) {
  warning("Deprecated. Use \"info_LMD_table\" instead.")
  if (year == 2012) {
    fname <- system.file("extdata/info/Contents-LUCAS-primary-data-12-20140618-.csv", package="lucas")
    lmd_data_description <- read.csv(fname, stringsAsFactors=F, sep=";", header=T)
  } else {
    stop("Description only available for the year 2012.")
  }
  if (! is.null(attr)) {
    lmd_data_description <- lmd_data_description[lmd_data_description$Label %in% attr, ]
  }
  
  for (i in 1:nrow(lmd_data_description)) {
    cat(paste0("\n************\n", 
               paste(lmd_data_description[i, 1:3], collapse=" | ")))
    if (lmd_data_description[i, 4] != "") {
      cat(paste0("\nVALUES:\n\t", gsub("\n", "\n\t", lmd_data_description[i, 4])))
    }
  }
  invisible(lmd_data_description)
}
