#' merge the update georeferences back to the main file.
#'
#' @param data_corrected After assigning coordinate values using online georeference tools such as GeoLocate, upload the csv file back to R with the name call data_corrected
#' @param data data table which needs to updated with the assign coordiantes
#' @param catalog this is an important attribute to use matching the records back to the main data file.
#'
#' @return data table with updated coordinate information
#' @importFrom dplyr coalesce
#' @importFrom dplyr mutate
#' @export
#'
#' @examples
#' data <- data.frame(
#'   species = "A",
#'   decimalLongitude = c(-120, -119.8, NA, NA),
#'   decimalLatitude = c(20, 34, NA, NA),
#'   cleaned_catalog = c("12345", "89888", "LACM8898", "SDNHM6767"),
#'   locality = c(NA, NA, "Los Angeles, CA", "San Pedro, CA"),
#'   coordinateUncertaintyInMeters = c(9999, NA, NA, NA)
#' )

#' data_corrected <- data.frame(
#' corrected_longitude = c(-120, -119.8, 118, 118.3),
#'  corrected_latitude = c(20, 34, 33, 32.9),
#'  cleaned_catalog = c("12345", "89888", "LACM8898", "SDNHM6767"),
#'  corrected_uncertainty = c(9999, NA, 5000, 1000)
#' )
#'
#'
#' data<- ec_merge_corrected_coordinates(data_corrected, data, catalog = cleaned_catalog)
#'
ec_merge_corrected_coordinates <- function(data_corrected, data, catalog = cleaned_catalog) {
  idx <- match(data$cleaned_catalog, data_corrected$cleaned_catalog)

  # Merge corrected values into the original data
  data <- data %>%
    dplyr::mutate(
      decimalLatitude = dplyr::coalesce(data_corrected$corrected_latitude[idx], decimalLatitude),
      decimalLongitude = dplyr::coalesce(data_corrected$corrected_longitude[idx], decimalLongitude),
      coordinateUncertaintyInMeters = dplyr::coalesce(data_corrected$corrected_uncertainty[idx], coordinateUncertaintyInMeters)
    )

  return(data)
}
