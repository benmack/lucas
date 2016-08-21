# From LMD point shape create lines with transects

# Small LMD set in epsg:3034
require(TimeTools)
require(sp)
fname_pts <- paste(path.package("TimeTools"),
                   "/extdata/Munich/LMD/LMD_2012_3034",sep="")
fname_lns <- gsub("_3034", "_3034_lines", fname_pts)
fname_pgs <- gsub("_3034", "_3034_polygons", fname_pts)
pts <- shapefile(fname_pts)


# ----
# assumung original (lat/long) coordinate system
pts <- spTransform(pts, CRS("+init=epsg:4326"))


# ----
# create lines
library(sp)
str(pts)
length(pts@coords)

points_to_transects <- function(pts) {
  coords_start <- pts@coords
  if (length(grep("longlat", pts@proj4string)) > 1) {
    coords_end <- offset_latlon_by_meter(coords_start[, 1], coords_start[, 2], de=250, dn=0)
  } else { # (in projected coord sys):
    coords_end <- coords_start
    coords_end[, 1] <- coords_end[, 1]+250
  }
  
  sl <- list()
  for (i in 1:length(pts)) {
    sl[[i]] <- Lines(Line(rbind(coords_start[i, ], coords_end[i, ])), ID=i)
  }
  sl <- SpatialLines(sl)
  sldf <- SpatialLinesDataFrame(sl, data = pts@data)
  sldf@proj4string <- pts@proj4string
  shapefile(sldf, fname_lns, overwrite=T)
  
  # ----
  # create polygons
  pgs <- gBuffer(pts, width=15, byid=T)
  shapefile(pgs, fname_pgs, overwrite=T)
}


