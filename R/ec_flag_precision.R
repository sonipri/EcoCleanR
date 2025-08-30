#' flag bad precision data points
#'
#' @param longitude decimalLongitude, this a field in the data file. We prefer to use decimalLongitude as accepeted name based on TDWG standards
#' @param latitude decimalLatitude, this a field in the data file. We prefer to use decimalLatitude as accepeted name based on TDWG standards
#' @param threshold set on 2
#'
#' @return a column which has flagged records showed bad records based on low precision as well as rounding

#'
#' @examples
#' \dontrun{
#' data <- data.frame(species = "A",
#'                   decimalLongitude = c(-120.67, -78, -110, -60, -75.5, -130.78, -10.2, 5.4),
#'                   decimalLatitude = c(20.7, 34.6, 30.0, 10.5, 40.4, 25.66, 15.0, 35.9)
#'                   )
#'
#' data$flag_cordinate_precision <- ec_flag_precision(data$decimalLongitude, data$decimalLatitude)
#'
#'}
#' @export
ec_flag_precision <- function(longitude, latitude, threshold = 2) {
  # Get decimal places
  long_decimal_places <- decimal_places(longitude)
  lat_decimal_places <- decimal_places(latitude)

  # Identify coordinates with < threshold decimal places
  low_prec_long <- long_decimal_places < threshold
  low_prec_lat <- lat_decimal_places < threshold

  # Function to check for rounded coordinates
  check_rounding <- function(coord) {
    coord_str <- as.character(coord)
    # Check if ends with .0 or .5
    return(grepl("^[-]?\\d+$|\\.0$|\\.5$", coord_str)) # changed on 1/5/2024 as this code was unable to read rounding for -ve coordinates
    # return(grepl("^\\d+$|\\.5$", coord_str))
  }

  # Apply rounding check to each coordinate and flag
  rounded_long <- sapply(longitude, check_rounding)
  rounded_lat <- sapply(latitude, check_rounding)

  # Flag as 1 if any coordinate meets both low precision and rounding criteria
  # flags <- (low_prec_long & rounded_long) | (low_prec_lat & rounded_lat)
  flags <- (low_prec_long & rounded_long) & (low_prec_lat & rounded_lat)
  return(as.integer(flags)) # Convert to integer to get 1s and 0s
}
