# dataset1: Documentation of data file - ecodata.rda

This data file is consider as raw data file after merging and removing
duplicate records of all data sources. e.g. this file is an output of
occurrence records of mollusc species "Mexacanthina lugubris" with all
modern records extracted from GBIF, OBIS, IDIGBIO and InvertEBase

## Usage

``` r
ecodata
```

## Format

A data frame with 1115 rows and 19 variables:

- X:

  index

- basisOfRecord:

  Type of record (e.g., preserved specimen, fossil)

- occurrenceStatus:

  Presence or absence of the organism

- institutionCode:

  Code of the institution that holds the record

- verbatimEventDate:

  Original recorded date of the event

- scientificName:

  Full scientific name of the organism

- individualCount:

  Number of individuals observed

- organismQuantity:

  Reported quantity of the organism

- abundance:

  Calculated or standardized abundance value

- decimalLatitude:

  Latitude in decimal degrees

- decimalLongitude:

  Longitude in decimal degrees

- coordinateUncertaintyInMeters:

  Uncertainty in coordinates (meters)

- locality:

  Named place where the occurrence was recorded

- verbatimLocality:

  Original text for locality description

- municipality:

  Municipality or town of the occurrence

- county:

  County where the record was observed

- stateProvince:

  State or province name

- country:

  Country name

- cleaned_catalog:

  Standardized catalog number for de-duplication

## Source

- used rgbif for GBIF, ridigbio for iDigBio, robis for OBIS and
  rsymbiota for InvertEBase
