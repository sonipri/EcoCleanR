# Calculate geographic distance and mahalanobis distance to estimate outlier probability of a data point

Calculate geographic distance and mahalanobis distance to estimate
outlier probability of a data point

## Usage

``` r
distance_calc(data, latitude, longitude, env_layers, itr = 15, k = 3)
```

## Arguments

- data:

  data table with spatial and environmental variables

- latitude:

  nested input from ec_flag_outlier

- longitude:

  nested input from ec_flag_outlier

- env_layers:

  header names of env variables. env_layers \<- c("Temperature", "pH")

- itr:

  iteration to run the clustering 100 or 1000 times

- k:

  number of cluster to choose in each iteration

## Value

A list of results that shows result of calculated distance for each
iteration

## Examples

``` r
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  temperature_mean = c(12, 13, 14),
  temperature_min = c(9, 6, 10),
  temperature_max = c(14, 16, 18)
)

env_layers <- c("temperature_mean", "temperature_min", " temperature_max")

result_list <- distance_calc(data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  env_layers,
  itr = 100,
  k = 3
)
```
