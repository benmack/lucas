#' Combine LMD from different countries in one SpatialPointsDataFrame
#'
#' @param lmddir directory with the LMD
#' @param countries countries to be merged
#' @param year year of LMD
#' @param dst filename of the merged data (ESRI shaefile)
#' @param dst_overwrite overwrite the destination file if it exists?
#' @param cols columns of LMD to be kept
#'
#' @return \code{\link{SpatialPointsDataFrame}}
#' @export
bind_lmd <- function(lmddir, countries, year=2012, cols=NULL,
                     dst=file.path(lmddir, 
                                   paste0("LMD", year, ".shp")),
                     dst_overwrite=FALSE, ...) {
  
  dir.create(dirname(dst), recursive = T, showWarnings = F)
  
  if (!file.exists(dst) | dst_overwrite) {
    
    lmd <- c()
    for (cntry in countries) {
      lmd.c <- get_lmd(lmddir, countries=cntry, years=year, cols=cols, 
                       spatial=F, save_shp=F)
      fn.lmd <- get_filename(lmddir = lmddir, year = year, country = cntry)
      lmd <- rbind(lmd, lmd.c)
    }
    # merge factor levels of transects
    lmd <- .transect_cols_as_factor(lmd)
    
    # convert character columns to factor columns 
    idx <- sapply(lmd, is.character)
    lmd[, idx] <- lapply(lmd[,idx] , factor)
    
    lmd.sp <- create_spatial_lmd(
      lmd, shp=dst, overwrite_layer=dst_overwrite)
  } else {
    rgdal::readOGR(dirname(dst), 
                   gsub(".shp", "", basename(dst)), ...)
  }
  
  invisible(lmd.sp)
}