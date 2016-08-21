source("buildignore/functions.R")

df2006 <- .get_countries(2006)
df2009 <- .get_countries(2009)
df2012 <- .get_countries(2012)

df <- unique(rbind(df2006, df2009, df2012))
df$x2006 <- FALSE
df$x2009 <- FALSE
df$x2012 <- FALSE

dflist <- list("2006"=df2006, "2009"=df2009, "2012"=df2012)

for (year in as.character(c(2006, 2009, 2012)))
  df[df$code %in% dflist[[year]]$code, paste0("x", year)] <- TRUE

df <- df[order(df$country),]
rownames(df) <- 1:nrow(df)

# ADD THE ISO CODES (required for downloading the countries boundaries)
trim <- function(x) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}
tbl <- scan("buildignore/countries_ISO_3166.txt", what="character", sep="\n")
tbl <- sapply(tbl, function(x) strsplit(x, "   "))
tbl <- lapply(tbl, function(x) sapply(x[x!=""], trim))
n <- length(tbl) - 1
df.iso <- data.frame(Country=character(n), A2=character(n), 
                     A3=character(n), Number=character(n),
                     stringsAsFactors=FALSE)
for (i in 1:n)
  df.iso[i,] <- tbl[[i+1]]

idxInWorld <- match(toupper(df$country), df.iso$Country)
df <- cbind(df, gadm=df.iso$A3[idxInWorld])

write.table(df, "inst/data/available_lmd.txt")
