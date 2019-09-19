context("animal_demographics")


test_that("Animal demographic data can be successfully extracted", {
  expect_true(!is.null(animal_demographics)) 
})

test_that("Animal demographic data has the expected number of columns",{
  expect_equal(ncol(animal_demographics), 5)
})

test_that("Animal demographic  data has at least 14,857 rows (19/09/19)",{
  expect_true(nrow(animal_demographics) > 14857)
})