# Filter records to georeference using GEOLocate

Filter records to georeference using GEOLocate

## Usage

``` r
ec_flag_with_locality(
  data,
  uncertainty = "coordinateUncertaintyInMeters",
  locality = "locality",
  verbatimLocality = "verbatimLocality"
)
```

## Arguments

- data:

  data table with occurrence information

- uncertainty:

  Mendatory to have coordinateUncertaintyInMeters column in the data
  table

- locality:

  Mandatory to have locality column in the data table.

- verbatimLocality:

  Mandatory to have verbatimLocality in the data table.

## Value

A column with flagged records as 1, which means these records has
potential to be georeferenced.

## Details

Records those does not have coordinates assigned but has locality and
varbatim locality information to assign coordinates by using external
tools such as GEOLocate

## Examples

``` r
data <- data.frame(
  coordinateUncertaintyInMeters = c(NA, "N/A", 50, "30", NA, "N/A", NA),
  locality = c("Santa Cruz", NA, "Los Angeles", "N/A", "", "San Diego", NA),
  verbatimLocality = c(NA, "CA coast", "", "N/A", "Long Beach", NA, "")
)
data$flag_check_geolocate <- ec_flag_with_locality(
data, uncertainty = "coordinateUncertaintyInMeters",
locality = "locality",
verbatimLocality = "verbatimLocality"
)
```
