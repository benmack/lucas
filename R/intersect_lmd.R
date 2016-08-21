intersect_lmd <- function(x, poly, ...) {
  idx <- apply(rgeos::gIntersects(x, poly, byid=TRUE), 2, any)
  xsub <- x[idx,]
  return(xsub)
}
