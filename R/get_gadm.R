#' Download Global Administrative Areas (GADM) 
#'
#' @param A3code Three letter ISO 3166 code(s) (see e.g. \url{http://www.davros.org/misc/iso3166.html}) 
#' @param level administrative level
#' @param destdir destination directory to store the data 
#' @param saveShp if not \code{NULL} the data is saved as  ESRI Shapefile. If \code{TRUE} or \code{'defualt'} it is written to a default filename and loction else it is assumed that the filename is given.
#' @param ... passed to \code{\link{writeOGR}}
#'
#' @return \code{\link{SpatialPointsDataFrame}}
#' @export
#' 
#' @seealso \url{http://www.gadm.org/}
#'
#' @examples
get_gadm <- function(A3code, level=0, destdir=NULL,
                     filename_shp=NULL, overwrite_shp=FALSE, ...) {
  
  
  spdf <- .getCountries(A3code, level, destdir, ...)
  if (!is.null(filename_shp)) {
    if (filename_shp=="default") {
      filename_shp <- paste0(destdir, "/",
                             paste(A3code, collapse="_"), "_",
                             "adm", level, ".shp")
    }
    if (!file.exists(filename_shp) | overwrite_shp)
      rgdal::writeOGR(spdf, dirname(filename_shp),
                      gsub('.shp', '', basename(filename_shp)),
                      driver="ESRI Shapefile", 
                      overwrite=overwrite_shp, ...)
  }
  #   if ((addShp & !is.null(destdir)) | !is.null(destShp)) {
  #     if ((addShp & !is.null(destdir)) & is.null(destShp))
  #       destShp <- paste0(destdir, "/",
  #                         paste(A3code, collapse="_"), "_",
  #                         "adm", level, ".shp")
  #     rgdal::writeOGR(spdf, dirname(destShp),
  #                     gsub('.shp', '', basename(destShp)),
  #                     driver="ESRI Shapefile", ...)
  #   }
  return(spdf)
}


# borrowed from:
# http://r.789695.n4.nabble.com/GADM-Data-Download-td4681254.html

.loadGADM <- function (A3code, level = 0, destdir=NULL, ...) {
  fname <- paste0(A3code, "_adm", level, ".rds")
  url <- paste("http://biogeo.ucdavis.edu/data/gadm2.8/rds/",
               fname, sep="")
  if (!is.null(destdir)) {
    fpath <- paste0(destdir, "/", fname)
  } else {
    fpath <- tempfile(fileext=".rds") 
  }
  if (!file.exists(fpath) | is.null(destdir)) {
    dir.create(dirname(fpath), recursive=TRUE, 
               showWarnings=FALSE)
    ans <- try(download.file(url, fpath, mode = "wb"),
               silent=TRUE)
    if (class(ans)=="try-error") {
      unlink(fpath)
      stop(ans)
    }
  }
  gadm <- readRDS(fpath)
  if (is.null(destdir))
    unlink(fpath)
  return(gadm)
}

## the maps objects get a prefix (like "ARG_" for Argentina)
.changeGADMPrefix <- function (GADM, prefix) {
  GADM <- sp::spChFIDs(GADM, paste(prefix, row.names(GADM), sep = "_"))
  GADM
}
## load file and change prefix
.loadChangePrefix <- function (fileName, level = 0, destdir=NULL, ...) {
  theFile <- .loadGADM(fileName, level, destdir)
  theFile <- .changeGADMPrefix(theFile, fileName)
  theFile
}

## this function creates a SpatialPolygonsDataFrame that contains all maps you specify in "fileNames".
## E.g.:
## spdf <- getCountries(c("ARG","BOL","CHL"))
## plot(spdf) # should draw a map with Brasil, Argentina and Chile on it.
.getCountries <- function (fileNames, level = 0, destdir=NULL, ...) {
  polygon <- sapply(fileNames, .loadChangePrefix, level, destdir)
  polyMap <- do.call("rbind", polygon)
  polyMap
}
