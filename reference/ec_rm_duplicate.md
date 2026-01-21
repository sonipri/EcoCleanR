# Remove Duplicate Records from the Merged Data

Remove Duplicate Records from the Merged Data

## Usage

``` r
ec_rm_duplicate(data, catalogNumber = "catalogNumber", abundance = "abundance")
```

## Arguments

- data:

  this is merge data frame which is a output file after running
  ec_db_merge

- catalogNumber:

  this is a mandatory field which consider unique for each occurrence
  record.

- abundance:

  this is a mandatory field which has created while data extraction by
  combining individual count and quantity fields (may vary from one
  source to another, we aim to standardize those as "abundance").

## Value

A data frame which has unique catalog numbers. the output file will have
cleaned_catalog field instead of catalogNumber. Also the unique record
will be chosen with the abundance value if there is any.

## Details

This function will provide a cleaned_catalog column as output, which has
catalog numbers standardize and removed duplicates based on generated
cleaned_catalog and abundance columns of data. mandatory fields are
catalogNumber, source and abundance

## Examples

``` r
db1 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  catalogNumber = c("12345", "89888", "LACM8898", "SDNHM6767"),
  occurrenceStatus = c("present", "", "ABSENT", "Present"),
  basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
  source = "db1",
  abundance = c(1, NA, 8, 23)
)

db2 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  catalogNumber = c("123452", "898828", "LACM82898", "SDNHM62767"),
  occurrenceStatus = c("present", "", "ABSENT", "Present"),
  basisOfRecord = c("preserved_specimen", "", "fossilspecimen", "material_sample"),
  source = "db2",
  abundance = c(1, 2, 3, 19)
)
db_list <- list(db1, db2)
merge_modern_data <- ec_db_merge(db_list = db_list, "modern")
ecodata <- ec_rm_duplicate(merge_modern_data,
  catalogNumber = "catalogNumber",
  abundance = "abundance"
)
```
