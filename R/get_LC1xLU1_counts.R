#' Get frequency table of LC1 & LU1 occurences
#'
#' @param df a data fram containing the columns LC1 and LU1
#' @param as_df \code{TRUE} retuns the result as a data frame with three columns: LC1, LU1 and count. Else a table.
#'
#' @return according to \code{as_df} a data frame or a table
#' @export
#'
#' @examples
get_LC1xLU1_counts <- function(df, as_df=TRUE) {
  counts <- table(df$LC1, df$LU1)
  if (as_df) {
    counts <- data.frame(
      LC1 = rep(rownames(counts), ncol(counts)),
      LU1 = rep(colnames(counts), each=nrow(counts)),
      count = counts[1:prod(dim(counts))])
    counts <- counts[counts$count>0, ]
    counts <- counts[order(counts$LC1, counts$LU1) , ]
  }
  return(counts)
}
