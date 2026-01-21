# Flag the Occurrences those has Extreme Uncertainty Error Radius

Flag the Occurrences those has Extreme Uncertainty Error Radius

## Usage

``` r
ec_filter_by_uncertainty(
  data,
  uncertainty_col = "coordinateUncertaintyInMeters",
  percentile = 0.96,
  ask = TRUE,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- data:

  data table which need to be cleaned with unwanted uncertainty values -
  extreme values

- uncertainty_col:

  coordinateUncertaintyInMeters column

- percentile:

  to derive threshold, e.g. extreme 5% uncertainty data points to be
  removed. give percentile value as 0.95

- ask:

  this allow user to decide if the uncertainty threshold value is okay
  or too high/low

- latitude:

  default set on decimalLatitude, this column is use to filter records
  those does not have georeferences.

- longitude:

  default set on decimalLongitude.

## Value

A data frame as result of removing extreme uncertain occurrences

## Examples

``` r
data <- data.frame(
  species = "A",
  decimalLongitude = c(-120, -117, NA, NA),
  decimalLatitude = c(20, 34, NA, NA),
  cleaned_catalog = c("12345", "89888", "LACM8898", "SDNHM6767"),
  locality = c(NA, NA, "Los Angeles, CA", "San Pedro, CA"),
  coordinateUncertaintyInMeters = c(1000, 2000, 9999900, NA)
)
data <- ec_filter_by_uncertainty(
  data,
  uncertainty_col = "coordinateUncertaintyInMeters",
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  percentile = 0.96,
  ask = TRUE
)
#> Suggested threshold at 96th percentile: 9200068
#> Do you want to apply this threshold? (y/n): 
#> No filtering applied.
```
