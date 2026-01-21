# dataset3: Documentation of data file - ecodata_with_outliers.rda

This data file created after running ec_flag_outlier function. It has
records with outlier probability

## Usage

``` r
ecodata_with_outliers
```

## Format

A data frame with 713 rows and 35 variables:

- X:

  index

- basisOfRecord:

  Type of occurrence record (e.g., preserved specimen, fossil)

- occurrenceStatus:

  Indicates presence or absence of the species

- institutionCode:

  Code of the institution that provided the record

- verbatimEventDate:

  Original text for the event or collection date

- scientificName:

  Scientific name of the organism

- individualCount:

  Number of individuals recorded

- organismQuantity:

  Reported quantity (unit may vary)

- abundance:

  Standardized or calculated abundance value

- decimalLatitude:

  Latitude in decimal degrees

- decimalLongitude:

  Longitude in decimal degrees

- coordinateUncertaintyInMeters:

  Spatial uncertainty of coordinates in meters

- locality:

  Named location where the record was collected

- verbatimLocality:

  Original locality text as provided by the source

- municipality:

  Municipality or town of occurrence

- county:

  County of occurrence

- stateProvince:

  State or province of occurrence

- country:

  Country of occurrence

- cleaned_catalog:

  Standardized catalog number used for de-duplication

- lat_precision:

  Number of decimal places in the latitude coordinate

- lon_precision:

  Number of decimal places in the longitude coordinate

- flag_cordinate_precision:

  Flag for low coordinate precision

- flag_cc_val:

  Flag for invalid or impossible coordinates

- flag_cc_equal:

  Flag for identical latitude and longitude (likely erroneous)

- flag_cc_zero:

  Flag for coordinates at (0,0)

- flag_cc_cent:

  Flag for coordinates placed at a country or region centroid

- flag_cc_gbif:

  Flag for coordinates matching GBIF headquarters (artifact)

- flag_cc_inst:

  Flag for coordinates matching institution location

- flag_non_region:

  Flag for coordinates outside the study region

- outliers:

  Flag for outliers based clustering of spatial and env variables

- BO_sstmean:

  Mean sea surface temperature from Bio-ORACLE

- BO_sstmax:

  Maximum sea surface temperature from Bio-ORACLE

- BO_sstmin:

  Minimum sea surface temperature from Bio-ORACLE

- BO_chloro:

  Chlorophyll concentration from Bio-ORACLE

- BO_dissox:

  Dissolved oxygen level from Bio-ORACLE

## Source

- this file was created manually after extracting the csv file from
  GEOLocate online software to assign coordiante and uncertainty values
  for the records has locality information
