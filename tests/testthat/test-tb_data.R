context("tb_data")


test_that("TB data can be successfully extracted", {
  skip_on_cran()
  expect_true(!is.null(tb_data())) 
})

test_that("TB data has the expected number of columns",{
  skip_on_cran()
  expect_equal(ncol(tb_data()), 11)
})

test_that("TB data has at least 1 row",{
  skip_on_cran()
  expect_true(nrow(tb_data()) > 0)
})

test_that("TB data can be filtered for an incidence floor",{
  skip_on_cran()
  expect_true(nrow(tb_data(inc_floor = 1e12)) == 0)
})

test_that("TB data can be filtered for an incidence rate floor",{
  skip_on_cran()
  expect_true(nrow(tb_data(inc_rate_floor = 1e12)) == 0)
})