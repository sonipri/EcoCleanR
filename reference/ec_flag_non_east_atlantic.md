# Flag the occurrences those are not in east Atlantic and are inland

Flag the occurrences those are not in east Atlantic and are inland

## Usage

``` r
ec_flag_non_east_atlantic(
  ocean_names,
  buffer_distance = 50000,
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
```

## Arguments

- ocean_names, :

  Insert the name of oceans: "South Pacific Ocean", "North Pacific
  Ocean", North Atlantic Ocean", "South Atlantic Ocean"

- buffer_distance, :

  Its a certain buffer distance to consider if a data point is inland.
  Beyond this distance data points consider as bad data points. e.g.
  buffer_distance \<- 25000

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
ocean_names <- c("North Atlantic Ocean", "South Atlantic Ocean")
buffer_distance <- 25000
data <- data.frame(
  species = "A",
  decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
  decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
)
data$flag_non_region <- ec_flag_non_east_atlantic(
  ocean_names,
  buffer_distance,
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
# }
```
