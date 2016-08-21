read_lmd <- function(xls, cols=NULL, spatial=FALSE, shp=NULL) {
  df = read.csv(xls, header = TRUE, stringsAsFactors=FALSE)
  cols_df <- colnames(df)
  cols_df <- gsub("GPS_LONG", par_lmd$long, cols_df)
  cols_df <- gsub("GPS_LAT", par_lmd$lat, cols_df)
  colnames(df) <- cols_df
  
  # df <- .convertCoords(df)
  
  if (is.null(cols)) {
    cols <- 1:ncol(df)
  } else {
    idx <- cols %in% cols_df
    if (any(!idx))
      warning(paste0("Columns not found and ignored: ",
                     paste(cols[idx], collapse=", ")))
    cols <- cols[idx]
  }
  df <- df[, cols]
  if (spatial)
    df <- create_spatial_lmd(df, shp=shp)
  return(df)
}
