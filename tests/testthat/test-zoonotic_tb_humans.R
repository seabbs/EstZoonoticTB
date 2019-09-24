context("zoonotic_tb_humans")


test_that("Zoonotic TB in humans data can be successfully extracted", {
  expect_true(!is.null(zoonotic_tb_humans)) 
})

test_that("Zoonotic TB in humans data has the expected number of columns",{
  expect_equal(ncol(zoonotic_tb_humans), 12)
})

test_that("Zoonotic TB in humans data has at least 201 rows (23/09/19)",{
  expect_true(nrow(zoonotic_tb_humans) >= 201)
})