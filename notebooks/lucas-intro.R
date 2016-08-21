# Use the latest code:
require(ggplot2)
require(devtools)
load_all(".")
# OR the installed package:
# require(lucas)

# ----

available_lmd <- get_lmd_overview()
available_lmd

# ----

cntry <- "DE"
cntryA3 <- available_lmd$gadm[available_lmd$code==cntry]
year <- 2015

# ----

a_tempdir <- tempdir()
a_tempdir

# ----

lmd_subsets[["a"]]
lmddir <- paste0(a_tempdir, "/LMD")
get_lmd(lmddir, countries=cntry, years=year, 
        cols=lmd_subsets[["a"]], verbosity=2)

# ----

load_all("..")

# ----



# ----



# ----



# ----



# ----



# ----



# ----



# ----



# ----
