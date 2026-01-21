# Flag Outlier Occurrences - using Spatial and Non-spatial Attributes

Flag Outlier Occurrences - using Spatial and Non-spatial Attributes

## Usage

``` r
ec_flag_outlier(
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  env_layers,
  itr = 50,
  k = 3,
  geo_quantile = 0.99,
  maha_quantile = 0.99
)
```

## Arguments

- data:

  data table with spatial and environmental variables

- latitude:

  default set to "deciamlLatitude"

- longitude:

  default set to "decimalLongitude"

- env_layers:

  header names of env variables. env_layers \<- c("Temperature", "pH")

- itr:

  iteration to run the clustering 100 or 1000 times

- k:

  number of cluster to choose in each iteration

- geo_quantile:

  value with geo_quantile percentile would consider has threshold for
  geo_distance to derive the outlier. e.g. default 0.99

- maha_quantile:

  value with maha_quantile percentile would consider has threshold for
  maha_distance to derive the outlier. e.g. default 0.99

## Value

A column call flag_outlier which has outlier probability from 0 to 1. 1
is more towards outlier, 0 more towards good data points.

## Examples

``` r
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  BO_sstmean = c(12, 13, 14),
  BO_sstmin = c(9, 6, 10),
  BO_sstmax = c(14, 16, 18)
)

env_layers <- c("BO_sstmean", "BO_sstmin", "BO_sstmax")
res <- ec_flag_outlier(data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  env_layers,
  itr = 100,
  k = 3,
  geo_quantile = 0.99,
  maha_quantile = 0.99
)
data$outlier <- res$outlier
iteration_list <- res$result$list
```
