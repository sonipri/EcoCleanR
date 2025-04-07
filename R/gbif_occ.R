#' Extract the data from GBIF for the species and required attributes
#'
#' @param species_name species of interest to get the occurrence data. e.g. "Mexacanthina lugubris"
#' @param attribute_list List of attribuites which you want to extract from GBIF. Use the same attribute list to extract data from other sources too.
#' @return a occurrence table from gbif, added and modified few fields
#' @importFrom rgbif name_backbone
#' @importFrom rgbif occ_data
#' @export
#'
#' @examples
#' species_name <- "Mexacanthina lugubris"
#' attribute_list <- c("source", "catalogNumber", "basisOfRecord", "occurrenceStatus", "institutionCode", "verbatimEventDate", "scientificName", "individualCount", "organismQuantity", "abundance", "decimalLatitude", "decimalLongitude", "coordinateUncertaintyInMeters", "locality", "verbatimLocality", "municipality", "county", "stateProvince", "country", "countryCode")
#' gbif_sp_occur <- gbif_occ(species_name, attribute_list)
#'
gbif_occ <- function(species_name, attribute_list) {
  taxonkey <- name_backbone(species_name)$usageKey
  gbif.occ <- rgbif::occ_data(taxonKey = taxonkey, occurrenceStatus = NULL, limit = 10000L)$data
  unique(gbif.occ$scientificName) # this code to assure if the taxons are correct synonyms or not
  # adding additional field with abundance value (merging individual count and organism quantity)
  gbif.occ$abundance <- ifelse(is.na(as.numeric(gbif.occ$individualCount)), as.numeric(gbif.occ$organismQuantity), as.numeric(gbif.occ$individualCount))
  gbif.occ$source <- "gbif"
  # choose fields to be added in temp table, based on gbif DWC names
  gbif.occ_temp <- gbif.occ[, attribute_list]
  return(gbif.occ_temp)
}
