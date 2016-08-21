#' Offset a latitude/longitude by some amount of meters 
#'
#' @param lat latitude of the starting point(s) in decimal degree
#' @param lon longitude of the starting points(s) in decimal degree
#' @param de offset towards east (in meter)
#' @param dn offset towards north (in meter)
#'
#' @return latitud and longitude of the offsetted points
#' @export
#' @seealso http://gis.stackexchange.com/questions/2951/algorithm-for-offsetting-a-latitude-longitude-by-some-amount-of-meters
offset_latlon_by_meter <- function(lat, lon, de=100, dn=100) {

# Earth’s radius, sphere
R=6378137

# Coordinate offsets in radians
dLat = dn/R
dLon = de/(R*cos(pi*lat/180))

#OffsetPosition, decimal degrees
latO = lat + dLat * 180/pi
lonO = lon + dLon * 180/pi
return(cbind(lat=latO, lon=lonO))
}