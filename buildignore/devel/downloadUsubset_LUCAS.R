require(lucas)
gadmdir <- "F:/TT/TESTDIR/Settings/Shapes/GADM"
lmddir <- "F:/TT/TESTDIR/Settings/Shapes/LMD"
fn.adb.sub <- "F:/TT/TESTDIR/Settings/Shapes/GADM/GADM_LK_Stanberg.shp"
fn.lmd.sp.sub <- "F:/TT/TESTDIR/Settings/Shapes/LMD/LMD_2012_aoi.shp"

country="DE"
year=2012
level=3

admsub = "Starnberg"
aoi = 'F:/TT/NEW_FEATURES/pcUcl/03_tiles/_TilesShape/tiles_2.shp' # 'F:/TT/NEW_FEATURES/pcUcl/aoi.shp'

get_lmd(lmddir, country, year, cols=lmd_subsets[["a"]])
fn.LC1a <- system.file("data/LC1_a.txt", package="lucas")
lut <- read.table(fn.LC1a, header=TRUE)
file.lmd <- paste0(lmddir, "/", year, "/", country, "_", year, ".xls")
lmd <- read_lmd(file.lmd)
lmd$LC1a <- reclassify_LULC(lmd$LC1, lut) 
file.lmd.sp <- gsub(".xls", ".shp", file.lmd)
lmd.sp <- create_spatial_lmd(lmd, shp=file.lmd.sp, overwrite_layer=TRUE)

# An AOI from GADM
# adm = get_gadm("DEU", level, gadmdir, addShp=TRUE, destShp=NULL)
# aoi <- adb[adb@data[, paste0("NAME_", level)]==admsub, ]

# Or from a shape
aoi <- readOGR(dirname(aoi), gsub(".shp", "", basename(aoi)))
aoi.proj.orig <- aoi@proj4string
aoi <- spTransform(aoi, lmd.sp@proj4string)
lmd.sp.sub <- intersect_lmd(lmd.sp, aoi)

lmd.sp.sub <- spTransform(lmd.sp.sub, aoi.proj.orig)

plot(aoi)
plot(lmd.sp.sub, add=TRUE)

writeOGR(lmd.sp.sub, dirname(fn.lmd.sp.sub), 
         gsub('.shp', '', basename(fn.lmd.sp.sub)), 
         driver="ESRI Shapefile")
writeOGR(adb.sub, dirname(fn.adb.sub), 
         gsub('.shp', '', basename(fn.adb.sub)), 
         driver="ESRI Shapefile")
