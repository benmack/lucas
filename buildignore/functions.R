.get_countries <- function(year) {
  file <- paste0("buildignore/countries_", year, ".txt")
  content <- scan(file, what="character", sep="\n")
  countries <- content[seq(2, length(content), by=2)]
  codes <- content[seq(1, length(content), by=2)]
  codes <- gsub("[[]", "", codes)
  codes <- gsub("[]]", "", codes)
  codes[codes=="GR"] <- "EL"
  df <- data.frame(country=countries, code=codes,
                   stringsAsFactors=FALSE)
  return(df)
  }
