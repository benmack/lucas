#' Convert country codes 
#'
#' @param x list of country names or country codes (lmd, gadm types). 
#' See \code{\link{get_lmd_overview}}. If \code{NULL} all available codes of 
#' type \code{code_type} are returned.
#' @param code_type the code type to be returned
#'
#' @return character vector with codes 
#' @export
get_country_code <- function(x=NULL, code_type="lmd") {
  if (!code_type%in%c("country", "lmd", "gadm"))
    stop("code_type must be country, lmd or gadm.")
  df <- get_lmd_overview()[, c("country", "code", "gadm")]
  colnames(df) <- c("country", "lmd", "gadm")
  if (is.null(x)) {
    code = df[, code_type]
  } else {
    src_type <- .get_source_type(x, df)
    idx <- match(x, df[, src_type])
    code <- df[idx, code_type]
  }
  return(code)
}

.get_source_type <- function(x, df=NULL) {
  if (is.null(df))
    df <- get_lmd_overview()[, c("country", "code", "gadm")]
  src <- sapply(df, function(src) all(x %in% src))
  if (!any(src))
    stop("Could not find all all values of x in any column of df.")
  src <- names(src)[src]
}
