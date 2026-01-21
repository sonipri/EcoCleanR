# Map view to visualize data points with outlier probability 0 to 1 on a map view

Map view to visualize data points with outlier probability 0 to 1 on a
map view

## Usage

``` r
ec_geographic_map_w_flag(
  data,
  flag_column,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- data:

  Data table which has information of coordinates (decimalLongitude and
  decimalLatitude) and a column which has flags 0 to 1

- flag_column:

  column name which has flag, e.g. flag_outlier

- latitude:

  default set on "decimalLatitude", change if the name of column is
  different.

- longitude:

  default set on "decimalLongitude", change if the name of column is
  different.

## Value

A geographic map which shows occurrence data points with the color
gradient to show flagged records in warm color.

## Examples

``` r
# \donttest{
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  temperature_mean = c(12, 13, 14),
  temperature_min = c(9, 6, 10),
  temperature_max = c(14, 16, 18),
  flag_outlier = c(0, 0.5, 1)
)
ec_geographic_map_w_flag(data,
  flag_column = "flag_outlier",
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
#> Ignoring unknown labels:
#> • colour : "Flag"

# }
```
