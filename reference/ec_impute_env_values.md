# Impute Environmental Variables using Mean Values of occurrences within a certain radius

Impute Environmental Variables using Mean Values of occurrences within a
certain radius

## Usage

``` r
ec_impute_env_values(
  data_x,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  radius_km = 10,
  iter = 3
)
```

## Arguments

- data_x:

  this is data_x which is the output of ec_extract_env_layers

- latitude:

  default set to "decimalLatitude"

- longitude:

  default set to "decimalLongitude"

- radius_km:

  radius to average the values of data points within the circle to imput
  the values for missing datta points

- iter:

  number of times to iterate the imputation, e.g. 1 or 2 or 3

## Value

An updated table of data_x which has imputed values for the missing env
variables, condition applies that the this imputation wont work if the
data points are too sparse.

## Examples

``` r
data_x <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9),
  BO_sstmean = c(12, NA, 14),
  BO_sstmin = c(9, NA, 10),
  BO_sstmax = c(14, NA, 18)
)
radius_km <- 10
iter <- 3
data_x <- ec_impute_env_values(data_x,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude",
  radius_km, iter
)
#> Imputation iteration 1
#> Imputation iteration 2
#> Imputation iteration 3
```
