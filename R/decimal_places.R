decimal_places <- function(coord) {
  if (!is.numeric(coord)) stop("Input must be a numeric vector.")

  coord_no_trail <- sapply(coord, function(x) {
    if (!is.na(x)) {
      ec_trail_zero(x)
    } else {
      NA
    }
  })

  count_decimal_places <- function(coord) {
    if (is.na(coord)) {
      return(NA)
    }
    coord_str <- as.character(coord)
    if (grepl("\\.", coord_str)) {
      return(nchar(sub(".*\\.", "", coord_str)))
    } else {
      return(0)
    }
  }

  dec_places <- sapply(coord_no_trail, count_decimal_places)
  return(dec_places)
}
