require(lucas)
# require(R.cache)
# setCacheRootPath(lmddir)
require(ggplot2)

gadmdir <- "F:/TT/DATA/GADM"
lmddir <- "F:/TT/DATA/LUCAS"
years <- c(2006, 2009, 2012)
years <- c(2012)
countries <- get_lmd_overview()$code
create_single_country_shape <- FALSE
create_all_countries_shape <- TRUE
idx_attr = 1:48
# ----

av_lmd <- get_lmd_overview()
av_lmd_all_years <- av_lmd[apply(av_lmd[, 3:5], 1, all), ]
get_lmd(lmddir, countries, years)



for (year in years) {
  lmd.merged <- NULL
  av_countries_yr <- av_lmd$code[av_lmd[, paste0("x", year)]]
  countries_yr <- countries[countries%in%av_countries_yr]
  for (country in countries_yr) {
    lmd <- read_lmd(get_filename(lmddir, year, country))
    lmd <- cbind(country=country, lmd)
    lmd.merged <- rbind(lmd.merged, lmd)
    if (create_single_country_shape)
      lmd.sp <- create_spatial_lmd(lmd[, idx_attr], shp=get_filename(lmddir, year, country, "shp"))
  }
  if (create_all_countries_shape)
    lmd.sp <- create_spatial_lmd(lmd.merged[, 1:48], shp=get_filename(lmddir, year, "ALL", "shp"))
  
  for (country in av_countries) {
    get_lmd(lmddir, country, year)
    df.i <- cbind(country=country, read_lmd(sprintf(xml_pattern, 
                                                    country, year)))
    df <- rbind(df, df.i)
  }
  df <- df[, 1:48]
  ind <- sapply(df, is.character)
  df[ind] <- lapply(df[ind], factor)
  df
}
# str(df)

sp <- create_spatial_lmd(df, shp=file.lmd.sp, overwrite_layer=TRUE)



# ----
tbl_LC1 <- table(df$LC1)
sort(tbl_LC1)
tbl_LC1["H12"]

gg <- ggplot(tbl_LC1) + geom_bar()
