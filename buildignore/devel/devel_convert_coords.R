
fn.lmd1 <- "devel_coords/2012/DE_2012.xls"
get_lmd("devel_coords/", countries="DE", years=2012, cols=lmd_subsets[["a"]])
lmd1 <- read_lmd(fn.lmd1) 
fn.lmd2 <- "inst/data/LMD/2012/UK_2012.xls"
get_lmd("devel_coords/", countries="UK", years=2012, cols=lmd_subsets[["a"]])
lmd2 <- read_lmd(fn.lmd2)


lmd1.sp <- create_spatial_lmd(lmd1, shp="devel_coords/shp/01_noConv_DE_2012.shp", 
                             overwrite_layer=TRUE)

lmd2.sp <- create_spatial_lmd(lmd2, shp="devel_coords/shp/01_noConv_UK_2012.shp",
                             overwrite_layer=TRUE)


lmd1.sp <- create_spatial_lmd(lmd1, shp="devel_coords/shp/03_sgnW_DE_2012.shp", 
                             overwrite_layer=TRUE)

lmd2.sp <- create_spatial_lmd(lmd2, shp="devel_coords/shp/03_sgnW_UK_2012.shp",
                             overwrite_layer=TRUE)

all(lmd2$GPS_Y_LAT==lmd2$Y_LAT)
plot(lmd2$GPS_Y_LAT, lmd2$Y_LAT)

all(lmd2$GPS_X_LONG==lmd2$X_LONG)
plot(lmd2$GPS_X_LONG, lmd2$X_LONG)


unique(lmd1$GPS_PROJ) == unique(lmd$GPS_PROJ)

unique(lmd1$GPS_EW) == unique(lmd$GPS_EW)

colnames(lmd)
str(lmd)
lmd[lmd$EW=="E", .coordNames$long]

idx <- sample(nrow(lmd), 1000)
plot(lmd$)


