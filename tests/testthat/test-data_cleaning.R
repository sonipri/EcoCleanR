
db1 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  catalogNumber = c("12345", "89888", "LACM8898", "SDNHM6767"),
  occurrenceStatus = c("present", NA, "ABSENT", "Present"),
  basisOfRecord = c("preserved_specimen", NA, "fossilspecimen", "material_sample"),
  source = "db1",
  abundance = c(1, 6, 23, 1)
)

db2 <- data.frame(
  species = "A",
  decimalLongitude = c(-120.2, -117.1, NA, NA),
  decimalLatitude = c(20.2, 34.1, NA, NA),
  catalogNumber = c("12345", "898828", "LACM82898", "SDNHM62767"),
  occurrenceStatus = c("present", "Absent", "present", "Present"),
  basisOfRecord = c("preserved_specimen", NA, "fossilspecimen", "material_sample"),
  source = "db2",
  abundance = c(1, 3, 8, 19)
)
# ec_db_merge
test_that("ec_db_merge works", {
  result <- ec_db_merge(datatype = "modern", db1, db2)
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 3)
  expect_equal(sum(table(result$catalogNumber)>1), 1)
})

#ec_rm_duplicate
test_that("ec_rm_duplicate works",{
  result <- ec_rm_duplicate(ec_db_merge(datatype = "modern", db1, db2), catalogNumber = "catalogNumber", abundance = "abundance")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 2)
  expect_equal(sum(table(result$cleaned_catalog)>1), 0)
  })

# load data file
test_data1 <- data.frame(
  scientificName = c("Mexacanthina lugubris", "Mexacanthina angelica", "Notareal species"),
  stringsAsFactors = FALSE
)
# ec_worms_synonym (Testing)
test_that("ec_worms_synonym works", {
  result <- ec_worms_synonym("Mexacanthina lugubris", test_data1)
  # Check it's a data frame
  expect_s3_class(result, "data.frame")
  # Check required columns exist
  expect_true(all(c("Accepted_syn_worms", "ecodata_syn_with_count") %in% colnames(result)))
  # Check the input species is in the WoRMS column
  expect_true("Mexacanthina lugubris" %in% result$Accepted_syn_worms)
  # Check record count formatting exists (e.g., "Mexacanthina lugubris (1)")
  expect_true(any(grepl("Mexacanthina lugubris \\([0-9]+\\)", result$ecodata_syn_with_count)))
})


# ec_flag_with_locality (Testing)
test_data2 <- data.frame(
  coordinateUncertaintyInMeters = c(NA, "N/A", 50, "30", NA, "N/A", NA),
  locality = c("Santa Cruz", NA, "Los Angeles", "N/A", "", "San Diego", NA),
  verbatimLocality = c(NA, "CA coast", "", "N/A", "Long Beach", NA, "")
)

test_that("ec_flag_locality works", {
  expect_equal(sum(ec_flag_with_locality(test_data2)), 4)
}) # 4 records has potential to assign georeferences using GeoLocate tool

# ec_flag_precision (Testing)
test_data3 <- data.frame(
  species = "Mexacanthina lugubris",
  decimalLongitude = c(-120.67, -78, -110, -60, -75.5, -130.78, -10.2, 5.4),
  decimalLatitude = c(20.7, 34.6, 30.0, 10.5, 40.4, 25.66, 15.0, 35.9)
)

test_that("ec_flag_precision", {
  expect_equal(sum(ec_flag_precision(test_data3$decimalLongitude, test_data3$decimalLatitude)), 2)
})


# ec_flag_non_region (testing)

test_data4 <- data.frame(
  species = "A",
  decimalLongitude = c(-120, -78, -110, -60, -75, -130, -10, 5),
  decimalLatitude = c(20, 34, 30, 10, 40, 25, 15, 35)
)
direction <- "east"
ocean <- "pacific"
buffer <- 25000
test_that("ec_flag_non_region works", {
  skip("Skipping ec_flag_non_region test - big shape files required to load for it")
  skip_on_cran()
  skip_on_ci()
  expect_equal(sum(ec_flag_non_region(direction, ocean, buffer, test_data4)), 6)
})

# ec_extract_env_layers(testing)
test_data5 <- data.frame(
  scientificName = "Mexacanthina lugubris",
  decimalLongitude = c(-116.24, -117.75, -115.8, -113.53),
  decimalLatitude = c(30.8, 33.5, 29.9, 31.31)
)
env_layers <- c("temperature_mean", "temperature_min", "temperature_max")
# layer_map <- list(
# temperature_mean = "BO_sstmean",
# temperature_max  = "BO_sstmax",
# temperature_min  = "BO_sstmin",
# Chloro           = "BO_chlomean",
# dissox           = "BO_dissox",
# salinity         = "BO_salinity",
# ph               = "BO_ph",
# dist_shore       = "MS_biogeo05_dist_shore_5m")

test_that("ec_extract_env_layers works", {
  skip("Skipping ec_extract_env_layers test - big shape files required to load for it")
  skip_on_cran()
  skip_on_ci()
  result <- ec_extract_env_layers(test_data5, env_layers)
  expect_s3_class(result, "data.frame")
  expect_true(all(env_layers %in% colnames(result)))
  expect_equal(nrow(result), nrow(test_data5))
})

# ec_impute_env_values (Testing)

test_data6 <- data.frame(
  decimalLongitude = c(-117.6, -117.6, -117.55, -116.9),
  decimalLatitude = c(32.9, 32.8, 32.77, 31.9),
  temperature_mean = c(12, NA, 20.5, 14),
  temperature_min = c(9, NA, 15.2, 10),
  temperature_max = c(14, NA, 11.5, 18)
)


radius_km <- 30
iter <- 3

test_that("ec_impute_env_values works", {
  result <- ec_impute_env_values(test_data6, radius_km, iter)
  expect_s3_class(result, "data.frame")
  expect_true(!any(is.na(result))) # for this example
})

# ec_flag_outlier (Testing)

test_data7 <- data.frame(
  decimalLatitude = c(
    8.40, 16.80, 19.28, 20.25, 20.25, 20.25, 22.92, 23.22, 23.95, 24.36,
    24.40, 24.40, 24.40, 24.42, 24.52, 24.53, 24.54, 24.55, 24.55, 24.60, 24.61, 24.63, 24.63
  ),
  decimalLongitude = c(
    -83.28, -99.90, -104.87, -105.58, -105.58, -105.58, -106.10, -106.42, -110.88, -110.34,
    -112.07, -112.07, -112.07, -111.73, -111.95, -112.03, -112.07, -112.07, -112.07,
    -112.08, -112.10, -112.02, -112.12
  ),
  temperature_mean = c(
    29.31, 29.36, 27.83, 28.02, 28.02, 28.02, 29.04, 26.73, 23.22, 25.11,
    21.88, 21.88, 21.88, 23.48, 22.40, 21.95, 21.95, 21.95, 21.95, 21.95, 21.49, 21.55, 21.49
  ),
  temperature_max = c(
    30.17, 31.31, 30.71, 32.42, 32.42, 32.42, 32.68, 31.30, 27.82, 30.01,
    27.23, 27.23, 27.23, 28.61, 27.44, 27.19, 27.19, 27.19, 27.19, 27.19, 26.94, 26.74, 26.94
  ),
  temperature_min = c(
    28.49, 27.18, 24.69, 23.62, 23.62, 23.62, 24.96, 22.43, 18.87, 20.71,
    17.82, 17.82, 17.82, 20.49, 19.52, 18.11, 18.11, 18.11, 18.11, 18.11, 17.51, 17.85, 17.51
  )
)

env_layers <- c("temperature_mean", "temperature_min", "temperature_max")

test_that("ec_flag_outlier works", {
  result <- ec_flag_outlier(test_data7, env_layers, itr = 100, k = 1, geo_quantile = 0.99, maha_quantile = 0.99)
  expect_equal(sum(result$outliers) > 0, TRUE)
})

# ec_geographic_map_w_flag

test_data7$outliers <- (ec_flag_outlier(test_data7, env_layers, itr = 100, k = 1, geo_quantile = 0.99, maha_quantile = 0.99))$outlier # result obtained from ec_flag_outliers
test_that("ec_geographic_map_w_flag works", {
  p <- ec_geographic_map_w_flag(test_data7, flag_column = "outliers")
  vdiffr::expect_doppelganger("map_w_flag.png", p)
})

# ec_geographic_map
test_that("ec_geographic_map_w_flag works", {
  p1 <- ec_geographic_map(test_data7)
  vdiffr::expect_doppelganger("map.png", p1)
})

# ec_var_summary

env_layers <- c("temperature_mean", "temperature_min", "temperature_max")
test_data8 <- test_data7 %>%
  dplyr::filter(outliers == 0)

test_that("ec_var_summary works", {
  result <- ec_var_summary(test_data8, env_layers)
  expect_s3_class(result, "data.frame")
  # Check required columns exist
  expect_true(all(c("Max", "Min", "Mean") %in% colnames(result)))
  # Check record count formatting exists (e.g., "Mexacanthina lugubris (1)")
  expect_true(!any(is.na(result)))
})

# ec_plot_var_range
env_layers <- c("temperature_mean", "temperature_min", "temperature_max")
test_that("ec_plot_var_range works", {
  p2 <- ec_plot_var_range(test_data7, ec_var_summary(test_data8, env_layers), env_layers) # this is the final cleaned data table which will be used to derive summary of acceptable niche
  vdiffr::expect_doppelganger("var_plot.png", p2)
})
