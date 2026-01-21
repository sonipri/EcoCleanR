# Flag occurrences those has bad precision

Flag occurrences those has bad precision

## Usage

``` r
ec_flag_precision(
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  threshold = 2
)
```

## Arguments

- data:

  dataframe

- latitude:

  decimalLatitude, this a field in the data file. We prefer to use
  decimalLatitude as accepeted name based on TDWG standards

- longitude:

  decimalLongitude, this a field in the data file. We prefer to use
  decimalLongitude as accepeted name based on TDWG standards

- threshold:

  set on 2

## Value

A column which has flagged records represents bad records based on low
precision as well as rounding

## Examples

``` r
data <- data.frame(
  species = "A",
  decimalLongitude = c(-120.67, -78, -110, -60, -75.5, -130.78, -10.2, 5.4),
  decimalLatitude = c(20.7, 34.6, 30.0, 10.5, 40.4, 25.66, 15.0, 35.9)
)

data$flag_cordinate_precision <- ec_flag_precision(
  data,
  latitude = "decimalLongitude",
  longitude = "decimalLatitude",
  threshold = 2
)
```
