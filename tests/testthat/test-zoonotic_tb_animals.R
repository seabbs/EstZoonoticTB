context("zoonotic_tb_animals")


test_that("Zoonotic TB in animals data can be successfully extracted", {
  expect_true(!is.null(zoonotic_tb_animals)) 
})

test_that("Zoonotic TB in animals data has the expected number of columns",{
  expect_equal(ncol(zoonotic_tb_animals), 6)
})

test_that("Zoonotic TB in animals data has at least 710 rows (19/09/19)",{
  expect_true(nrow(zoonotic_tb_animals) >= 710)
})