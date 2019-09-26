context("get_latest_data")


test_that("The latest zoonotic TB data can successfully be extracted from the linked data", {
  skip_on_cran()
  expect_true(!is.null(get_latest_data(link_data(verbose = FALSE), tb_z_prop)))
})

test_that("The latest zoonotic TB data has the expected number of columns using default datasets.",{
  skip_on_cran()
  expect_equal(ncol(get_latest_data(link_data(verbose = FALSE), tb_z_prop)), 26)
})

test_that("The latest zoonotic TB data has at least 1 row",{
  skip_on_cran()
  expect_true(nrow(get_latest_data(link_data(verbose = FALSE), tb_z_prop)) > 0)
})

