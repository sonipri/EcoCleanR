# Remove Duplicate Records from the Merged Data based on occurrenceID

Remove Duplicate Records from the Merged Data based on occurrenceID

## Usage

``` r
ec_rm_duplicate_occurid(
  data,
  occurrenceID = "occurrenceID",
  abundance = "abundance"
)
```

## Arguments

- data:

  this is merge data frame which is a output file after running
  ec_db_merge

- occurrenceID:

  this is a mandatory field which consider unique for each occurrence
  record.

- abundance:

  this is a mandatory field which has created while data extraction by
  combining individual count and quantity fields (may vary from one
  source to another, we aim to standardize those as "abundance").

## Value

A data frame which has unique occurrenceID. the output file will have
cleaned_occurrenceID field instead of occurrenceID. Also the unique
record will be chosen with the abundance value if there is any.

## Details

This function will provide a cleaned_occurrenceID column as output,
which has occurrenceID standardize and removed duplicates based on
generated cleaned_occurrenceID and abundance columns of data. mandatory
fields are occurrenceID, source and abundance

## Examples

``` r
db1 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  occurrenceID = c("12345", "898828", "LACM8289", "SDNHM6276"),
  occurrenceStatus = c("present", "", "ABSENT", "Present"),
  basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
  source = "db1",
  abundance = c(1, NA, 8, 23)
)

db2 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  occurrenceID = c("12345", "898828", "LACM82898", "SDNHM62767"),
  occurrenceStatus = c("present", "", "ABSENT", "Present"),
  basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
  source = "db2",
  abundance = c(1, 2, 3, 19)
)
db_list <- list(db1, db2)
merge_modern_data <- ec_db_merge(
  db_list = db_list, "modern"
)
ecodata <- ec_rm_duplicate_occurid(
  merge_modern_data,
  occurrenceID = "occurrenceID",
  abundance = "abundance"
)
```
