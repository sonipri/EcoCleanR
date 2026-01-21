# dataset2: Documentation of data file - ecodata_corrected.rda

This data file created by using GEOLocate tool and we only kept 4
columns. These georeference information will be merge back with the main
data file ecodata

## Usage

``` r
ecodata_corrected
```

## Format

A data frame with 433 rows and 4 variables:

- cleaned_catalog:

  catalog number

- corrected_latitude:

  latitude values assigned by GEOLocate

- corrected_longitude:

  longitude values assigned by GEOLocate

- corrected_uncertainty:

  uncertainty values assigned by GEOLocate

## Source

- this file was created manually after extracting the csv file from
  GEOLocate online software to assign coordiante and uncertainty values
  for the records has locality information
