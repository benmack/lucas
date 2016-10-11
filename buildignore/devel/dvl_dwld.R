require(devtools)
load_all(".")

sdf <- get_lmd(destdir="F:/EU/Countries/EU28/LMD",
               countries="EU28", 
               years=2015,
               cols=NULL, 
               overwrite=FALSE, 
               spatial=TRUE,
               save_shp=TRUE,
               keep_original=FALSE,
               verbosity=1) 


