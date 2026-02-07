# Flag Occurrences those are in wrong ocean basins and are inland

Flag Occurrences those are in wrong ocean basins and are inland

## Usage

``` r
ec_flag_non_region(
  direction,
  ocean,
  buffer = 50000,
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- direction, :

  values as "east" or "west". These values help to filter the shape
  files for east or west of select ocean (e.g. pacific) for both north
  and south hemisphere.

- ocean, :

  values such as "pacific" or "atlantic"

- buffer, :

  Its a certain buffer distance to consider if a data point is inland.
  Beyond this distance data points consider as bad data points. e.g.
  buffer \<- 25000

- data, :

  Data table which has latitude and longitude information

- latitude:

  default set to "decimalLatitude"

- longitude:

  default set to "decimalLongitude"

## Value

A new column with flagged values, 1 means bad records 0 means good
record. Column name: flag_non_region

## Examples

``` r
# \donttest{
direction <- "east"
buffer <- 25000
ocean <- "pacific"
data <- data.frame(
  species = "A",
  decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
  decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
)
data$flag_non_region <- ec_flag_non_region(
  direction,
  ocean,
  buffer = 50000,
  data
)
#> Cache is fresh. Reading: /tmp/RtmpfspCoy/goas-9d9829c8/goas.shp
#> (Last Modified: 2026-02-07 01:20:29.623347)
#> Cache is fresh. Reading: /tmp/RtmpfspCoy/goas-be75374d/goas.shp
#> (Last Modified: 2026-02-07 01:20:52.354707)
# }
```
