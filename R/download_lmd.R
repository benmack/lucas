#' Download a LMD file - but better use get_lmd.
#'
#' @param code Country code (LUCAS code)
#' @param year Year
#' @param destfile File to write the file to
#' @param return_df Return the data frame? Else NULL is returned.
#' @param keep_original Keep the orignal downloaded file?
#'
#' @return data frame or NULL
download_lmd <- function(code, year, destfile=NULL, keep_original=FALSE, return_df=FALSE) {
  
  if (is.null(destfile))
    destfile <- paste0(destdir, "/", year, "/", .get_lmd_fname(code, year))
  
  # For the conversion, else writeOGR creates strange column names
  attr_tbl <- get_lmd_attributes_overview()
  
  url <- lucas:::.get_lmd_url(code, year, suffix="_20160728")
  msg <- try(download.file(url, destfile))
  if (class(msg)=="try-error") {
    url <- lucas:::.get_lmd_url(code, year, suffix="_20160921")
    msg <- try(download.file(url, destfile))
  }

  if (msg!=0)
    stop("Could not download:", url)
  
  if (keep_original)
    file.copy(destfile, gsub(".csv", "_ORIGINAL.csv", destfile))
  
  df = read.csv(destfile, header = TRUE, stringsAsFactors=FALSE)
  
  # Convert column names
  idx <- match(colnames(df), attr_tbl[, paste0("X", year)])
  # CHECK WITH:
  # cbind(colnames(df), attr_tbl$USE[idx])
  
  colnames(df) <- attr_tbl$USE[idx]
  
  # Convert transect info to one-column style
  idx_transect <- grep("TR[0-9]", colnames(df))
  if (length(idx_transect)>0) {
    transect <- df[, idx_transect]
    transect[transect==""] <- NA
    
    transect_new <- apply(transect, 1, paste, collapse=";")
    transect_new <- gsub(";NA", "", transect_new)
    df <- df[, -idx_transect]
    df <- cbind(df, TRANSECT=transect_new)
    df$TRANSECT=transect_new
  }
  
  write.csv(df, destfile, quote=F, row.names=F)
  
  if (return_df)
    return(df)
  return (NULL)
  
}
