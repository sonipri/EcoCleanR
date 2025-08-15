#---- function for getting synonym comparision from itis vs merged data

#' Title
#'
#' @param species_name input species name.e.g. Mexacanthina lugubris
#' @param data data table which has information of all occurrence data of the selected species
#'
#' @return a table with two columns, column one represent the accepted synonyms, and column two demonstrate the unique species names from the occurrence data base with the number of records tagged under species names.
#' @importFrom taxize get_ids
#' @importFrom taxize synonyms
#' @import dplyr
#' @export
#'
#' @examples
#' species_name = "Felis leo"
#' data <- data.frame(scientificName = "Felis leo",
#'                   decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
#'                   decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
#'                   )
#'comparison <- ec_itis_synonym(species_name, data)
#'print(comparison)
#'library(taxize)

# ec_itis_synonym <- function(species_name, data) {
#
# # Step 1: Get itis ID and synonyms
# itis_id <- get_ids(species_name, "itis")
#
# #stop the code if no match found in itis:
#
# if(is.na(itis_id[["itis"]][[1]])){
#   stop("no match found in itis taxonomy database")
# }
#
# itis_syn <- synonyms(itis_id[["itis"]][[1]], db = "itis")
#
# # Step 2: Extract unique scientific names from WoRMS synonyms and input ecodata
# itis_syn_df <- itis_syn[[1]]
# unique_itis <- unique(dplyr::select(itis_syn_df, syn_name))
# ecodata_counts <- data %>%
#   dplyr::group_by(scientificName) %>%
#   dplyr::summarise(record_count = n(), .groups = "drop")
#
# ecodata_counts <- ecodata_counts %>%
#   dplyr::mutate(scientificName_with_count = paste0(scientificName, " (", record_count, ")"))
#
# # Step 3: Convert to vectors and sort
# vec_itis <- sort(c(as.vector(unique_itis$syn_name), species_name))
# vec_data <- ecodata_counts$scientificName_with_count
#
# # Step 4: Make lengths equal
# max_length <- max(length(vec_itis), length(vec_data))
# vec_itis <- c(vec_itis, rep(NA, max_length - length(vec_itis)))
# vec_data <- c(vec_data, rep(NA, max_length - length(vec_data)))
#
# # Step 5: Create a comparison table
# comparison_table <- data.frame(
#   Accepted_syn_itis = vec_itis,
#   ecodata_syn_with_count = vec_data
# )
# # Return the comparison table
# return(comparison_table)
#
# }

