context("get_latest_combined_data")


test_that("The latest combined data can successfully be extracted from the linked data", {
  skip_on_cran()
  expect_true(!is.null(get_latest_combined_data(link_data(verbose = FALSE))))
})

test_that("The latest combined data has the expected number of columns using default datasets.",{
  skip_on_cran()
  expect_equal(ncol(get_latest_combined_data(link_data(verbose = FALSE))), 30)
})

test_that("The latest combined data has at least 1 row",{
  skip_on_cran()
  expect_true(nrow(get_latest_combined_data(link_data(verbose = FALSE))) > 0)
})

