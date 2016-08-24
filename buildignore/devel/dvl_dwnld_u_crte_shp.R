# ----
# get_lmd

code = "AT"
year = 2012
destdir = "D:/TEMP"
keep_original = FALSE

# ---- main function
lmd = get_lmd(destdir=destdir, countries=code, years=year, 
              spatial=TRUE, save_shp=TRUE, keep_original=TRUE)

# ---- ---- ----
# DETAILS
# ----
# For the attribute name  conversion
attr_tbl <- get_lmd_attributes_overview()

write.csv(attr_tbl, row.names=F, quote=F, file="lucas_attributes.csv")

# ---- 
# Get the URL
url <- .get_lmd_url(code, year)

# ----
# Download and convert - dir must exist, is done in get_lmd()
download_lmd(code, year, destfile=NULL, return_df=FALSE)

# ...
