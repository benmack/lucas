require(rgeos)

biogeo <- "d:/PROCESSING_RESULTS/2016_06_EARSeL_Symposium_Bonn/EuHD/Ecoregions/BiogeoRegions2016_shapefile/BiogeoRegions2016.shp"
dstdir <- "d:/PROCESSING_RESULTS/2016_06_EARSeL_Symposium_Bonn/EuHD/Ecoregions/BiogeoRegions2016_shapefile"

require(raster)
# biogeo <- shapefile(biogeo)
lmd <- get_lmd(destdir = dstdir, countries = "LU", year=2012, spatial=TRUE,
                    save_shp=TRUE)

# inter <- gIntersection(lmd, biogeo) 
