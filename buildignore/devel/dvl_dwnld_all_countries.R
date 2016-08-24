require(lucas)
# require(R.cache)
# setCacheRootPath(lmddir)
require(ggplot2)


get_lmd_overview()

# Defaults
lmddir <- "F:/EU/Countries_LMD"
years <- c(2006, 2009, 2012, 2015)
countries <- get_lmd_overview()$code
create_single_country_shape <- TRUE
create_all_countries_shape <- TRUE
# of 
download_all(lmddir)

# ----

# sp <- create_spatial_lmd(df, shp=file.lmd.sp, overwrite_layer=TRUE)
# 
# # ----
# tbl_LC1 <- table(df$LC1)
# sort(tbl_LC1)
# tbl_LC1["H12"]
# 
# gg <- ggplot(tbl_LC1) + geom_bar()
