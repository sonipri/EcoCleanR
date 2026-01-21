# A Summary Table of Final Cleaned Spatial and Environmental Variables

A Summary Table of Final Cleaned Spatial and Environmental Variables

## Usage

``` r
ec_var_summary(
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  env_layers
)
```

## Arguments

- data:

  data table after cleaning the records

- latitude:

  default set to "decimalLatitude"

- longitude:

  default set to "decimalLongitude"

- env_layers:

  an array of col names of enviornmental layers

## Value

A summary table with the mean, min and max values of final cleaned
spatial and environmental variables

## Examples

``` r
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9, -116.5),
  decimalLatitude = c(32.9, 33.5, 31.9, 32.4),
  BO_sstmean = c(12, 13, 14, 11),
  BO_sstmin = c(9, 6, 10, 10),
  BO_sstmax = c(14, 16, 18, 17)
)
env_layers <- c("BO_sstmean", "BO_sstmin", "BO_sstmax")
ec_var_summary(data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  env_layers
)
#>           variable    Max    Min    Mean
#> 1  decimalLatitude   33.5   31.9   32.67
#> 2 decimalLongitude -116.5 -117.8 -117.05
#> 3       BO_sstmean   14.0   11.0   12.50
#> 4        BO_sstmin   10.0    6.0    8.75
#> 5        BO_sstmax   18.0   14.0   16.25
```
