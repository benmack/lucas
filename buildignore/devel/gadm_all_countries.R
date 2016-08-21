lmd_av <- get_lmd_overview()
gadm_lmd2012 <- lmd_av$gadm[lmd_av$x2012]
destdir <- system.file("gitignore", package="lucas")

countries <- get_gadm(gadm_lmd2012, level=0, destdir=destdir, 
                      saveShp=file.path(destdir, "GADM_LMD2012"))
