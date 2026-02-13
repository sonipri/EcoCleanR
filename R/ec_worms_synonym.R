#' Check Accepted Synonyms from WoRMs Taxonomy
#' @param species_name input species name.e.g. Mexacanthina lugubris
#' @param data data table which has information of all occurrence data of the selected species
#' @param scientificName default set to scientificName, this is a column in the data extracted from online sources, may have various synonyms of species_name.
#' @param verbose default value as TRUE
#' @return A table with two columns, column one represent the accepted synonyms, and column two demonstrate the unique species names from the occurrence data base with the number of records tagged under species names.
#' @importFrom worrms wm_records_name
#' @importFrom worrms wm_synonyms
#' @import dplyr
#' @export
#'
#' @examples
#' \dontrun{
#' species_name <- "Mexacanthina lugubris"
#' data <- data.frame(
#'   scientificName = "Mexacanthina lugubris",
#'   decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
#'   decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
#' )
#' comparison <- ec_worms_synonym(
#'   species_name,
#'   data,
#'   scientificName = "scientificName",
#'   verbose = TRUE
#' )
#' print(comparison)
#' }
ec_worms_synonym <- function(species_name, data, scientificName = "scientificName", verbose = TRUE) {
  if (verbose) {
    message(sprintf("Querying WoRMS for '%s'...", species_name))
  }

  worms_id <- tryCatch(
    wm_records_name(species_name),
    error = function(e) NULL
  )

  # Case 1: Not found
  if (is.null(worms_id) || nrow(worms_id) == 0) {
    if (verbose) message(sprintf("[NOT FOUND]'%s' not found in WoRMS.", species_name))
    return(NULL)
  }

  aphia_id <- worms_id$AphiaID[1]
  status <- if ("status" %in% names(worms_id)) worms_id$status[1] else NA_character_

  if (verbose) message(sprintf("[FOUND] Found AphiaID: %s (status: %s)", aphia_id, status))

  # If NOT accepted → show valid_name and stop
  if (!identical(status, "accepted")) {
    valid_name <- if ("valid_name" %in% names(worms_id)) worms_id$valid_name[1] else NA_character_

    if (verbose) {
      message("Name is not accepted in WoRMS.")
      message(sprintf("Valid (accepted) name: %s", valid_name))
      message("Please rerun the function using the accepted name.")
    }

    return(NULL)
  }

  # Accepted → get synonyms (use aphia_id)
  worms_syn <- tryCatch(
    wm_synonyms(aphia_id),
    error = function(e) NULL
  )

  # Safety: if synonyms call fails, don't break downstream
  if (is.null(worms_syn) || nrow(worms_syn) == 0) {
    worms_syn <- data.frame(scientificname = character(), stringsAsFactors = FALSE)
  }

  # Step 2: Extract unique scientific names from WoRMS synonyms and input ecodata
  worms_syn_df <- worms_syn
  unique_worms <- unique(dplyr::select(worms_syn_df, "scientificname"))

  ecodata_counts <- data %>%
    dplyr::group_by(.data[[scientificName]]) %>%
    dplyr::summarise(record_count = dplyr::n(), .groups = "drop") %>%
    dplyr::mutate(scientificName_with_count = paste0(.data[[scientificName]], " (", .data$record_count, ")"))

  # Step 3: Convert to vectors and sort
  vec_worms <- sort(c(as.vector(unique_worms$scientificname), species_name))
  vec_data <- ecodata_counts$scientificName_with_count

  # Step 4: Make lengths equal
  max_length <- max(length(vec_worms), length(vec_data))
  vec_worms <- c(vec_worms, rep(NA, max_length - length(vec_worms)))
  vec_data <- c(vec_data, rep(NA, max_length - length(vec_data)))

  # Step 5: Create a comparison table
  comparison_table <- data.frame(
    Accepted_syn_worms = vec_worms,
    ecodata_syn_with_count = vec_data
  )

  return(comparison_table)
}
