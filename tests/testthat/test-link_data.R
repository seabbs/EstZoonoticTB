context("link_data")


test_that("Linked data can be successfully extracted.", {
  skip_on_cran()
  expect_true(!is.null(link_data())) 
})

test_that("Linked data has the expected number of columns using default datasets.",{
  skip_on_cran()
  expect_equal(ncol(tb_data()), 22)
})

test_that("Linked data has at least 1 row",{
  skip_on_cran()
  expect_true(nrow(tb_data()) > 0)
})
