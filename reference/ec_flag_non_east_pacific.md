# Flag occurrences those are not in east Pacific and are inland

Flag occurrences those are not in east Pacific and are inland

## Usage

``` r
ec_flag_non_east_pacific(
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
if (FALSE) { # \dontrun{
ocean_names <- c("North Pacific Ocean", "South Pacific Ocean")
buffer_distance <- 25000
data <- data.frame(
  species = "A",
  decimalLongitude = c(-120, -78, -110),
  decimalLatitude = c(20, 34, 30)
)
data$flag_non_region <- ec_flag_non_east_pacific(
  ocean_names,
  buffer_distance,
  data,
  latitude = "decimalLatitude",
  longitude = "decimalLongitude"
)
} # }
```
