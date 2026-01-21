# Extract the Environmental data

Extract the Environmental data

## Usage

``` r
ec_extract_env_layers(
  data,
  env_layers = env_layers,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- data:

  data table which has coordinate information

- env_layers:

  make a list of enviornmental layers which need to be extracted,
  example :BO_sstmean, BO_sstmax, BO_sstmin, BO_chomean, BO_phosphate or
  marspec layer, must check list_layer to know exact name of the layer
  code.

- latitude:

  default assigned as "decimalLatitude"

- longitude:

  default assigned as "decimalLongitude"

## Value

A data table which has unique coordinates and env predictors

## Examples

``` r
env_layers <- c("BO_sstmean", "BO_chlomean", "BO_dissox", "BO_salinity")
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-117, -117.8, -116.9),
  decimalLatitude = c(32.9, 33.5, 31.9)
)

data_x <- ec_extract_env_layers(data,
  env_layers = env_layers,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
#> Extracting BO_sstmean...
#> Extracting BO_chlomean...
#> Extracting BO_dissox...
#> Extracting BO_salinity...
```
