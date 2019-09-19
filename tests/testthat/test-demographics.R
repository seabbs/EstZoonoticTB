context("demographics")


test_that("Demographic data can be successfully extracted", {
  expect_true(!is.null(demographics)) 
})

test_that("Demographic data has the expected number of columns",{
  expect_equal(ncol(demographics), 5)
})

test_that("Demographic  data has at least 14,857 rows (19/09/19)",{
  expect_true(nrow(demographics) > 14857)
})