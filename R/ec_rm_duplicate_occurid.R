#' Remove Duplicate Records from the Merged Data based on occurrenceID
#' @details This function will provide a cleaned_occurrenceID column as output, which has occurrenceID standardize and removed duplicates based on generated cleaned_occurrenceID and abundance columns of data.
#' mandatory fields are occurrenceID, source and abundance
#' @param data this is merge data frame which is a output file after running ec_db_merge
#' @param occurrenceID this is a mandatory field which consider unique for each occurrence record.
#' @param abundance this is a mandatory field which has created while data extraction by combining individual count and quantity fields (may vary from one source to another, we aim to standardize those as "abundance").
#'
#' @return A data frame which has unique occurrenceID. the output file will have cleaned_occurrenceID field instead of occurrenceID. Also the unique record will be chosen with the abundance value if there is any.
#' @export
#' @importFrom rlang sym
#' @import dplyr
#' @examples
#'
#' db1 <- data.frame(
#'   species = "A",
#'   decimalLongitude = c(-120.2, -117.1, NA, NA),
#'   decimalLatitude = c(20.2, 34.1, NA, NA),
#'   occurrenceID = c("12345", "898828", "LACM8289", "SDNHM6276"),
#'   occurrenceStatus = c("present", "", "ABSENT", "Present"),
#'   basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
#'   source = "db1",
#'   abundance = c(1, NA, 8, 23)
#' )
#'
#' db2 <- data.frame(
#'   species = "A",
#'   decimalLongitude = c(-120.2, -117.1, NA, NA),
#'   decimalLatitude = c(20.2, 34.1, NA, NA),
#'   occurrenceID = c("12345", "898828", "LACM82898", "SDNHM62767"),
#'   occurrenceStatus = c("present", "", "ABSENT", "Present"),
#'   basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
#'   source = "db2",
#'   abundance = c(1, 2, 3, 19)
#' )
#' db_list <- list(db1, db2)
#' merge_modern_data <- ec_db_merge(
#'   db_list = db_list, "modern"
#' )
#' ecodata <- ec_rm_duplicate_occurid(
#'   merge_modern_data,
#'   occurrenceID = "occurrenceID",
#'   abundance = "abundance"
#' )
#'
ec_rm_duplicate_occurid <- function(data,
                                    occurrenceID = "occurrenceID",
                                    abundance = "abundance") {
  id_col <- rlang::sym(occurrenceID)
  abun_col <- rlang::sym(abundance)

  # Remove 'source' column if it exists
  data <- data[, !names(data) %in% "source", drop = FALSE]

  # Clean occurrenceID (keep as character; normalize whitespace/case)
  data <- data %>%
    dplyr::mutate(
      cleaned_occurrenceID = dplyr::na_if(trimws(as.character(!!id_col)), "")
    )

  # Remove original occurrenceID column
  data <- data %>% dplyr::select(-!!id_col)

  # Split: rows with ID vs without ID
  with_id <- data %>% dplyr::filter(!is.na(.data$cleaned_occurrenceID))
  no_id <- data %>% dplyr::filter(is.na(.data$cleaned_occurrenceID))

  # Deduplicate only where occurrenceID exists
  with_id <- with_id %>%
    dplyr::group_by(.data$cleaned_occurrenceID) %>%
    dplyr::slice(
      if (any(!is.na(!!abun_col))) {
        which(!is.na(!!abun_col))[1] # keep first non-NA abundance
      } else {
        1
      }
    ) %>%
    dplyr::ungroup()

  # Combine back (missing occurrenceID rows preserved)
  dplyr::bind_rows(with_id, no_id)
}
