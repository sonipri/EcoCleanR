# Calculate Harversine distance

Calculate Harversine distance

## Usage

``` r
haversine_kmeans(data, latitude, longitude, k)
```

## Arguments

- data:

  is a dataframe with spatial attributes - Latitude and Logitude

- latitude:

  nested imput from ec_flag_outlier

- longitude:

  nested imput from ec_flag_outlier

- k:

  is number of cluster required for the data set you have. Normally
  visual inspection can give a sense on number of clusters. Cautious to
  have more than expected clusters to fit all data points, as
  overfitting can end up inluding bad data points in the analysis. e.g.
  k = 3

## Value

A data frame with centroid and clusters using Harversine distance matrix

## Examples

``` r
data_x <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  BO_sstmean = c(12, 13, 14),
  BO_sstmin = c(9, 6, 10),
  BO_sstmax = c(14, 16, 18)
)

result <- haversine_kmeans(
  data_x,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  k = 3
)
```
