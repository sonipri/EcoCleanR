test_that("Flag records non pacific", {
  skip("Skipping this test for now — data-dependent")

  expect_equal(ec_flag_non_east_pacific(ocean, buffer, data))
})
