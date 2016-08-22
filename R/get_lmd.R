#' Download and/or load LUCAS Micro Data (LMD)
#'
#' @param destdir destination directory to store the data 
#' @param countries the countries to be downloaded
#' @param years the years to be downloaded
#' @param cols the columns (attributes) to keep 
#' @param overwrite should existing files be overwritten
#' @param spatial if \code{TRUE} a \code{\link{SpatialPointsDataFrame}} is returned
#' @param save_shp if \code{TRUE} the data is tored as ESRI shapefile
#' @param keep_original Keep the original file with the attribute/column names not changed? 
#' @param verbosity Info?
#'
#' @return LMD data as data frame (if \code{spatial=FALSE}) or spatial points data frame (if \code{spatial=TRUE}) (invisible) 
#' @export LMD as table or SpatialPointsDataFrame 
get_lmd <- function(destdir=NULL,
                    countries=NULL, 
                    years=NULL,
                    cols=NULL, 
                    overwrite=FALSE, 
                    spatial=FALSE,
                    save_shp=FALSE,
                    keep_original=FALSE,
                    verbosity=1) {
  
  if (is.null(destdir)) {
    destdir <- tempdir()
    if (verbosity>0)
      cat("Destination directory given. Saving data to \n\t", destdir, "\n")
  }
  shp <- NULL
  if (save_shp) {
    # save_shp is stronger
    spatial <- TRUE
  }
  
  available_lmd <- get_lmd_overview()
  if (is.null(years))
    years <- c(2006, 2009, 2012, 2015)
  if (is.null(countries))
    countries <- available_lmd$code
  wrong_codes <- !countries %in% available_lmd$code
  if (any(wrong_codes))
    stop(cat(sprintf(
      paste0(
        "The following country codes are not correct:\n%s\n",
        "Valid values are:\n%s\n"),
      paste(countries[wrong_codes], collapse=", "),
      paste(available_lmd$code, collapse=", "))))
  
  downloadlist <- expand.grid(code=countries, year=years)
  idx <- logical(nrow(downloadlist))
  for (year in years) {
    av_c <- available_lmd$code[available_lmd[, paste0("x", year)]]
    idx <- idx | (downloadlist$code %in% av_c & downloadlist$year == year)
  }
  downloadlist <- downloadlist[idx, ]
  n_downloads <- nrow(downloadlist)
  failed <- c()
  for (i in 1:n_downloads) {
    year <- downloadlist$year[i]
    code <- downloadlist$code[i]
    country <- available_lmd$gadm[available_lmd$code==code]
    if (save_shp)
      shp <- get_filename(destdir, year, country, type="shp")
    if (verbosity>0)
      cat(sprintf(paste0("-----------------------------------\n",
                         "Downloading (%s/%s) %s (%s), %d\n"),
                  i, n_downloads, country, code, year))
    destfile <- paste0(destdir, "/", year, "/", .get_lmd_fname(code, year))
    dir.create(dirname(destfile), recursive=TRUE, showWarnings=FALSE)
    
    if (!file.exists(destfile) | overwrite) {
      ans <- download_lmd(code, year, destfile=destfile, keep_original=keep_original ,return_df=FALSE)
      if (class(ans) == "try-error") {
        # warning("DOWNLOAD FAILED!!!")
        try(unlink(destfile), silent=TRUE)
        failed <- rbind(failed, downloadlist[i, ])
      } else {
        lmd <- read_lmd(destfile, cols=cols)
        write.csv(lmd, file=destfile,
                  quote=FALSE, row.names=FALSE)
        if (spatial) {
          lmd <- create_spatial_lmd(lmd, shp=shp)
        }
      }
    } else {
      cat("LMD already exists. Loaded from", destfile, "\n")
      lmd <- read_lmd(destfile, cols=cols, spatial=spatial, shp=shp)
    }
  }
  if (!is.null(nrow(failed))) {
    print("The following downloads failed:")
    print(failed)
  }
  invisible(lmd)
}