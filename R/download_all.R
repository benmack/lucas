#' Download all countries of all years and create shapefiles.
#'
#' @param lmddir The base directory for the data. In this, a directory
#' will be ceated for each year. 
#' @param years The years for which to download the data. Possible: 2006, 2009, 2012, 2015.
#' @param countries The countries to be downloaded in LMD code style 
#' (see \code{\link{(LMD code style)}}\code{$code}).
#' If \code{NULL} all available countries of a year are downloaded.
#' @param create_single_country_shape Should shapefiles be created for each country?
#' @param create_all_countries_shape Should a shapefile be created containing the 
#' points of all countries? 
#'
#' @return NULL
#' @export
download_all <- function(lmddir, 
                         years=c(2006, 2009, 2012, 2015), 
                         countries=NULL, 
                         create_single_country_shape=TRUE,
                         create_all_countries_shape=TRUE) {
  
  if (is.null(countries))
    countries <- get_lmd_overview()$code
  
   av_lmd <- get_lmd_overview()
  
  for (year in years) {
    cat()
    lmd.merged <- NULL
    av_countries_yr <- av_lmd$code[av_lmd[, paste0("x", year)]]
    countries_yr <- countries[countries%in%av_countries_yr]
    for (country in countries_yr) {
      country_gadm = av_lmd$gadm[av_lmd$code==country]
      lmd = get_lmd(lmddir, country, year)
      lmd <- cbind(country=country, lmd)
      lmd.merged <- rbind(lmd.merged, lmd)
      if (create_single_country_shape)
        lmd.sp <- create_spatial_lmd(lmd, shp=get_filename(lmddir, year, country_gadm, "shp"))
    }
    if (create_all_countries_shape)
      lmd.sp <- create_spatial_lmd(lmd.merged, shp=get_filename(lmddir, year, "ALL", "shp"))
    #   
    #   for (country in av_countries_yr) {
    #     get_lmd(lmddir, country, year)
    #     df.i <- cbind(country=country_gadm, read_lmd(get_filename(lmddir, year, country)))
    #     df <- rbind(df, df.i)
    #   }
    #   ind <- sapply(df, is.character)
    #   df[ind] <- lapply(df[ind], factor)
    #   df
  }
  return(NULL)
}
