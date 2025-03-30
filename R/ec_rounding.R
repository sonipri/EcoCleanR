# Define the function
ec_rounding <- function(coordinate) {
  # Extract the decimal part
  coordinate <- coordinate[!is.na(coordinate)]
  data_precision <- sapply(coordinate, decimal_places)
  data_low_precision <- abs(coordinate[data_precision < 2])

  # If no coordinates with low precision, return NA
  if (length(data_low_precision) == 0) {
    return(list(p_value_zero = NA, p_value_five = NA))
  }

  # Extract the decimal part
  decimals <- round(data_low_precision %% 1, 1)

  # Count occurrences of common rounding decimals like .0 and .5
  zero_count <- sum(decimals == 0.0)
  five_count <- sum(decimals == 0.5)

  # Total number of coordinates with low decimal precision
  n <- length(coordinate)

  # Perform binomial tests for .0 and .5
  p_zero <- binom.test(zero_count, n, p = 0.5)$p.value
  p_five <- binom.test(five_count, n, p = 0.5)$p.value

  # Return the results
  return(list(p_value_zero = p_zero, p_value_five = p_five))
}
