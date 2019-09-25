context("global_map")


data <- suppressWarnings(
  EstZoonoticTB::link_data(verbose = FALSE) %>% 
  dplyr::filter(!is.na(tb_z_prop)) %>% 
  dplyr::mutate(country = country %>% 
                  as.character) %>% 
  dplyr::group_by(country) %>% 
  dplyr::arrange(desc(year)) %>% 
  dplyr::slice(1) %>% 
  dplyr::ungroup()
)


test_that("global_map produces a map", {
  
  plot <- global_map(data, variable = "tb_z_prop")
  
  expect_true(!is.null(plot))
  expect_equal("ggplot", class(plot)[2])
  skip_on_cran()
  vdiffr::expect_doppelganger("base-map", plot)
})

test_that("global_map produces a plot when a sqrt transform is used", {
  
  plot <- global_map(data, variable = "tb_z_prop", trans = "sqrt")
  
  
  expect_true(!is.null(suppressWarnings(plot)))
  expect_equal("ggplot", class(suppressWarnings(plot))[2])
  skip_on_cran()
  vdiffr::expect_doppelganger("sqrt-map", suppressWarnings(plot))
})


test_that("global_map errors as expected", {
  
 expect_error(global_map())
 expect_error(global_map(data))
})