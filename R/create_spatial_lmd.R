#' Convert LMD data to a SpatialPointsDataFrame
#'
#' @description Create a \code{\link{SpatialPointsDataFrame}} from a LMD (-like) data frame as returned by \code{\link{get_lmd}}.
#'
#' @param df data frame as returned by \code{\link{get_lmd}}
#' @param shp filename in case the spatial points data frame should be stored to a shapefile, \code{NULL} otherwise.
#' @param ... passed to \code{\link{writeOGR}}  
#'
#' @return \code{\link{SpatialPointsDataFrame}}
#' @export
#' @examples
create_spatial_lmd <- function(df, shp=NULL, ...) {
  
  if (any(df$EW=="W"))
    df[df$EW=="W", par_lmd$long] <- -abs(df[df$EW=="W", par_lmd$long])
  
  coords <- df[, c(par_lmd$long, par_lmd$lat)]
  crs <- sp::CRS("+proj=longlat +datum=WGS84")
  spdf <- sp::SpatialPointsDataFrame(coords, df,
                                     proj4string=crs, 
                                     match.ID=TRUE)
  cat("Converting LMD to SpatialPointsDataFrame.\n")
  if (!is.null(shp)) {
    dir.create(dirname(shp), recursive=TRUE, showWarnings=FALSE)
    if (!file.exists(shp)) {
      cat("Saving LMD as ESRI Shapefile to", shp, "\n")
      rgdal::writeOGR(
        spdf, dirname(shp), gsub('.shp', '', basename(shp)),
        driver="ESRI Shapefile", ...)
    } else {
      cat("Shape file already exists:", shp)
    }
  }
  return(spdf)
}