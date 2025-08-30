#' extract the environmental layers
#'
#' @param data data table which has coordinate information
#' @param env_layers make a list of enviornmental layers which need to be extracted, example :BO_sstmean, BO_sstmax, BO_sstmin, BO_chomean, BO_phosphate or marspec layer, must check list_layer to know exact name of the layer code.
#' @return a data table which has unique coordinates and env predictors
#' @export
#' @importFrom sdmpredictors list_layers
#' @importFrom sdmpredictors load_layers
#' @importFrom terra extract
#'
#' @examples
#' env_layers <- c("BO_sstmean", "BO_Chlomean", "BO_dissox", "BO_salinity")
#' data <- data.frame(
#'   scientificName = "Mexacanthina lugubris",
#'   decimalLongitude = c(-117, -117.8, -116.9),
#'   decimalLatitude = c(32.9, 33.5, 31.9)
#' )
#'
#' data_x <- ec_extract_env_layers(data, env_layers = env_layers)
#'
ec_extract_env_layers <- function(data, env_layers = env_layers) {
  # Unique coordinates
  data_x <- unique(data[, c("decimalLatitude", "decimalLongitude")])
  coordinates <- data_x[, c("decimalLongitude", "decimalLatitude")]

  available_layers <- sdmpredictors::list_layers() # returns something like c("BO_sstmean", "BO_sstmax", ...)
  for (layer_name in env_layers) {
    if (layer_name %in% available_layers$layer_code) {
      message("Extracting ", layer_name, "...")
      layer_data <- sdmpredictors::load_layers(layer_name, rasterstack = TRUE)
      extracted_values <- terra::extract(layer_data, coordinates)
      data_x[[layer_name]] <- extracted_values
    } else {
      warning("Layer '", layer_name, "' not available. Skipping.")
    }
  }

  return(data_x)

}
