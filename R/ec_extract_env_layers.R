#' Extract the environmental layers for the data file based on coordinate information
#' Source: Bio-oracle
#'
#' @param data data table which has coordinate information
#' @param env_layers make a list of enviornmental layers which need to be extracted, example :temperature_mean, temperature_max, temperature_min, Chloro, dissox, salinity, ph, dist_shore
#' @return a data table which has unique coordinates and env predictors
#' @export
#' @importFrom sdmpredictors load_layers
#' @importFrom terra extract
#'
#' @examples
#' env_layers <- c("temperature_mean", "Chloro", "dissox", "salinity")
#' data <- data.frame(
#'   scientificName = "Mexacanthina lugubris",
#'   decimalLongitude = c(-117, -117.8, -116.9),
#'   decimalLatitude = c(32.9, 33.5, 31.9)
#' )
#'
#' data_x <- ec_extract_env_layers(data, env_layers = env_layers)
#'
ec_extract_env_layers <- function(data, env_layers = c("temperature_mean", "temperature_max", "temperature_min", "Chloro", "dissox")) {
  # Unique coordinates
  data_x <- unique(data[, c("decimalLatitude", "decimalLongitude")])
  coordinates <- data_x[, c("decimalLongitude", "decimalLatitude")]

  # Define mapping from user-friendly names to Bio-ORACLE codes
  layer_map <- list(
    temperature_mean = "BO_sstmean",
    temperature_max  = "BO_sstmax",
    temperature_min  = "BO_sstmin",
    Chloro           = "BO_chlomean",
    dissox           = "BO_dissox",
    salinity         = "BO_salinity",
    ph               = "BO_ph",
    dist_shore       = "MS_biogeo05_dist_shore_5m"
    # Add more mappings as needed
  )

  for (layer_name in env_layers) {
    if (layer_name %in% names(layer_map)) {
      message("Extracting ", layer_name, "...")
      layer_code <- layer_map[[layer_name]]
      layer_data <- load_layers(layer_code, rasterstack = TRUE)
      extracted_values <- terra::extract(layer_data, coordinates)
      data_x[[layer_name]] <- extracted_values
    } else {
      warning("Layer '", layer_name, "' not recognized. Skipping.")
    }
  }

  return(data_x)
}
