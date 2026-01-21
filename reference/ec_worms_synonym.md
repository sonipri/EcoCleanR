# Check Accepted Synonyms from WoRMs Taxonomy

Check Accepted Synonyms from WoRMs Taxonomy

## Usage

``` r
ec_worms_synonym(species_name, data, scientificName = "scientificName")
```

## Arguments

- species_name:

  input species name.e.g. Mexacanthina lugubris

- data:

  data table which has information of all occurrence data of the
  selected species

- scientificName:

  default set to scientificName, this is a column in the data extracted
  from online sources, may have various synonyms of species_name.

## Value

A table with two columns, column one represent the accepted synonyms,
and column two demonstrate the unique species names from the occurrence
data base with the number of records tagged under species names.

## Examples

``` r
species_name <- "Mexacanthina lugubris"
data <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
  decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
)
comparison <- ec_worms_synonym(species_name, data, scientificName = "scientificName")
#> ══  1 queries  ═══════════════
#> 
#> Retrieving data for taxon 'Mexacanthina lugubris'
#> ✔  Found:  Mexacanthina lugubris
#> ══  Results  ═════════════════
#> 
#> • Total: 1 
#> • Found: 1 
#> • Not Found: 0
print(comparison)
#>       Accepted_syn_worms    ecodata_syn_with_count
#> 1     Acanthina lugubris Mexacanthina lugubris (8)
#> 2  Acanthina tyrianthina                      <NA>
#> 3       Buccinum armatum                      <NA>
#> 4  Mexacanthina lugubris                      <NA>
#> 5      Monoceros cymatum                      <NA>
#> 6 Monoceros denticulatum                      <NA>
#> 7      Monoceros lugubre                      <NA>
```
