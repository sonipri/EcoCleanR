#' This function can be used to remove extreme uncertainty associate occurrence points
#'
#' @param data data table which need to be cleaned with unwanted uncertainty values - extreme values
#' @param uncertainty_col coordinateUncertaintyInMeters column
#' @param percentile to derive threshold, e.g. extreme 5% uncertainty data points to be removed. give percentile value as 0.95
#' @param ask this allow user to decide if the uncertainty threshold value is okay or too high/low
#'
#' @return a clean data table with removed extreme uncertain data points
#' @export
#'
#' @examples
#' data <- data.frame(species = "A",
#'                   decimalLongitude = c(-120, -117, NA, NA),
#'                   decimalLatitude = c(20, 34, NA, NA),
#'                   cleaned_catalog = c("12345", "89888", "LACM8898", "SDNHM6767"),
#'                   locality = c(NA, NA, "Los Angeles, CA", "San Pedro, CA"),
#'                   coordinateUncertaintyInMeters = c(1000, 2000, 9999900, NA)
#'                   )
#' data <- ec_filter_by_uncertainty(data, uncertainty_col = "coordinateUncertaintyInMeters", percentile = 0.96, ask = TRUE)
#'
#'
#'
ec_filter_by_uncertainty <- function(data, uncertainty_col = "coordinateUncertaintyInMeters", percentile = 0.96, ask = TRUE) {
  # Ensure the uncertainty column is numeric
  data[[uncertainty_col]] <- as.numeric(data[[uncertainty_col]])

  # Calculate the threshold value
  threshold <- quantile(data[[uncertainty_col]], percentile, na.rm = TRUE)
  message("Suggested threshold at ", percentile * 100, "th percentile: ", round(threshold, 2))

  # Ask user to confirm before filtering (if ask = TRUE)
  if (ask) {
    user_input <- readline(prompt = "Do you want to apply this threshold? (y/n): ")
    if (tolower(user_input) != "y") {
      message("No filtering applied.")
      return(data)
    }
  }

  # Apply filter
  data <- data %>%
    filter(
      is.na(.data[[uncertainty_col]]) | .data[[uncertainty_col]] <= threshold,
      !is.na(decimalLatitude)
    )

  return(data)
}
