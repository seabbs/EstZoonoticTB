context("link_data")


test_that("Linked data can be successfully extracted.", {
  skip_on_cran()
  expect_true(!is.null(link_data(verbose = FALSE))) 
})

test_that("Linked data has the expected number of columns using default datasets.",{
  skip_on_cran()
  expect_equal(ncol(link_data(verbose = FALSE)), 26)
})

test_that("Linked data has at least 1 row",{
  skip_on_cran()
  expect_true(nrow(link_data(verbose = FALSE)) > 0)
})


test_that("Linking data can produce verbose progress messages",{
  skip_on_cran()
  expect_true(invisible(
    suppressMessages(
      is.data.frame(link_data(verbose = TRUE)
      )
    )
    )
  )
})
