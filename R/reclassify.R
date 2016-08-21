#' Reclassifiy LUCAS data with a look-up-table
#'
#' @param x the vector of classes to be reclassified
#' @param lut the look up table with 
#'
#' @return vector with new classes
#' @export
#'
#' @examples
reclassify_LULC <- function(x, lut) {
  if (class(lut)=="character")
    lut = get_reclassify_lut(lut)
  x.new <- numeric(length(x))
  for (i in 1:nrow(lut)) {
    x.new <- .reclassify_one(lut[i,2], lut[i,1], x, x.new)
  }
  return(x.new)
}

.reclassify_one <- function(newId, pattern, oldVect, newVect) {
  idx = grep(pattern, oldVect)
  tbl <- table(oldVect[idx])
  #print(tbl)
  #print(sum(tbl))
  newVect[idx] <- newId
  return(newVect)
}
