ec_trail_zero <- function(coord) {
  coord_num <- as.numeric(coord)
  coord_cleaned <- sub("0+$", "", coord) # Remove trailing zeros
  coord_cleaned <- sub("\\.$", "", coord_cleaned) # Remove decimal point if it's the last character
  return(coord_cleaned)
}
