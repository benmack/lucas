
bdir <- "O:/Bayern/_SHAPES"

require(lucas)
require(raster) # for the handy shapefile function

year <- 2012
gadmdir <- file.path(bdir, "GADM")
lmddir <- file.path(bdir, "LMD")
overwrite <- TRUE
epsg = 32632

# Get Bavaria shape for subsetting LMD
aoi <- get_gadm("DEU", level=1, destdir=gadmdir, overwrite_shp=FALSE)
aoi <- aoi[aoi@data$NAME_1=="Bayern", ]

year=2006
for (year in c(2006, 2009, 2012)) {
  # download DEU LMD and subset 
  lmd <- get_lmd(lmddir, "DE", years=year, spatial=TRUE, save_shp=FALSE)
  aoi <- spTransform(aoi, lmd@proj4string)
  lmd <- intersect_lmd(lmd, aoi)
  
  # plot(aoi)
  # points(lmd)
  
  # Save ESRI Shapefile
  dst_fn <- get_filename(
    lmddir, year, country=paste0("DEU_Bayern_", epsg), type="shp")
  lmd <- spTransform(lmd, CRSobj=CRS(paste0("+init=epsg:", epsg)))
  lmd@data <- data.frame(LC1nC9=reclassify_LULC(lmd$LC1, lut="LC1nC9"),
                         lmd@data)
  lmd@data <- data.frame(LC1nC10=reclassify_LULC(lmd$LC1, lut="LC1nC10"),
                         lmd@data)
  lmd@data <- data.frame(maize=(lmd$LC1=="B16")+1, lmd@data)
  if (!file.exists(dst_fn) | overwrite)
    shapefile(lmd, file=dst_fn, overwrite=overwrite)
}
