# Map view of occurrence data points

Map view of occurrence data points

## Usage

``` r
ec_geographic_map(
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- data:

  Data table

- latitude:

  default set to "decimalLatitude"

- longitude:

  default set to "decimalLongitude"

## Value

A map view shows occurrence records.

## Examples

``` r
if (FALSE) { # \dontrun{
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  temperature_mean = c(12, 13, 14),
  temperature_min = c(9, 6, 10),
  temperature_max = c(14, 16, 18)
)
ec_geographic_map(data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
} # }
```
