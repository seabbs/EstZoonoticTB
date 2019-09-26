#' Extract the Lastest Data for Each Variable of Interest
#'
#'
#' @return A dataframe containing the latest data on each variable of interest - along with a flag
#' indicating which year the data is from.
#' @export
#'
#' @inheritParams get_latest_data
#' @importFrom dplyr select full_join
#' @examples
#' 
#' df <- link_data(verbose = FALSE)
#' 
#' get_latest_combined_data(df)
#' 
get_latest_combined_data <- function(data) {


# Prep --------------------------------------------------------------------

  cattle_per_head <- NULL; country <- NULL; country_code <- NULL;
  desc <- NULL; g_whoregion <- NULL;  population <- NULL;
  prop_hiv <- NULL; prop_hiv_hi <- NULL; prop_hiv_lo <- NULL; prop_rural <- NULL;
  prop_tb_ep <- NULL; tb_cases <- NULL; tb_inc <- NULL; tb_inc_hi <- NULL;
  tb_inc_lo <- NULL; tb_z_prop <- NULL; tb_z_prop_hi <- NULL; tb_z_prop_lo <- NULL;
  tb_z_prop_se <- NULL; year <- NULL; z_tb_dom_animal <- NULL; z_tb_geo_coverage <- NULL;
  z_tb_id <- NULL; z_tb_multi_year_study <- NULL; z_tb_study_pop <- NULL; z_tb_wild_animal <- NULL;
# Prop of TB that is zoonotic ---------------------------------------------

  z_tb <- get_latest_data(data, tb_z_prop) %>% 
    dplyr::select(country, country_code, z_tb_year = year,
                  z_tb_id, z_tb_geo_coverage, z_tb_study_pop,
                  z_tb_multi_year_study, tb_z_prop, tb_z_prop_lo,
                  tb_z_prop_hi, tb_z_prop_se)


# Zoonotic TB in animals --------------------------------------------------

  z_tb_animals <- get_latest_data(data, z_tb_dom_animal) %>% 
    dplyr::select(country, country_code, z_tb_animal_year = year,
                  z_tb_dom_animal, z_tb_wild_animal)
  
# TB incidence rate data --------------------------------------------------
 
  tb <- get_latest_data(data, tb_inc) %>% 
    dplyr::select(country, country_code, g_whoregion, tb_year = year,
                  tb_cases, tb_inc, tb_inc_lo, tb_inc_hi, prop_tb_ep,
                  prop_hiv, prop_hiv_lo, prop_hiv_hi)

# Animal demographic data -------------------------------------------------

  cattle <- get_latest_data(data, cattle)   %>% 
    dplyr::select(country, country_code, animal_year = year,
                  cattle, cattle_per_head)
  
# Demographic data --------------------------------------------------------
 
  demo <- get_latest_data(data, population) %>% 
    dplyr::select(country, country_code, demo_year = year,
                  population, prop_rural)


# Join all data -----------------------------------------------------------

  out <- tb %>% 
    dplyr::full_join(z_tb, by = c("country", "country_code")) %>% 
    dplyr::full_join(z_tb_animals, by = c("country", "country_code")) %>% 
    dplyr::full_join(demo, by = c("country", "country_code")) %>% 
    dplyr::full_join(cattle, by = c("country", "country_code"))
    
  
  return(out)  
  
}