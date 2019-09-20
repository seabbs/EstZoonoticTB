#' Tuberculosis data from the World Health Organization (WHO).
#'
#' @description This function relies on [getTBinR](https://www.samabbott.co.uk/getTBinR/) to source WHO tuberculosis (TB)
#' data. It then curates this data - extracting the country, region, year, TB incidence, 
#' TB incidence rates (+ CI's), the proportion of cases with extra-pulmonary TB, and the proportion of cases with HIV (+ CI's). 
#' Data prior to 2000 is dropped.
#' @param inc_floor Numeric, defaults to NULL. What is the minimum incidence to keep in the data.
#' @param inc_rate_floor Numeric, defaults to NULL. What is the minimum incidence
#' rate (per 100,000) to keep in the data.
#' @return A dataframe containing curated TB data from the WHO.
#' @export
#' @importFrom dplyr select mutate filter
#' @importFrom tidyselect contains
#' @seealso get_tb_burden
#' @examples
#' 
#' ## Get the data
#' tb_data()
tb_data <- function(inc_floor = NULL, inc_rate_floor = NULL) {
  ## Assign NULL for packaging
  country <- NULL; e_inc_100k <- NULL; e_inc_100k_hi <- NULL;
  e_inc_100k_lo <- NULL; e_inc_num <- NULL; e_inc_tbhiv_100k <- NULL;
  e_inc_tbhiv_100k_hi <- NULL; e_inc_tbhiv_100k_lo <- NULL; g_whoregion <- NULL;
  iso3 <- NULL; tb_cases <- NULL; year <- NULL; tb_inc <- NULL;
  
  ## Pull data
  tb <- EstZoonoticTB::get_tb_burden(additional_datasets = "all")
  
  ## Pull out a selection of data
  tb <- tb %>% 
    dplyr::select(country, iso3, g_whoregion, year, tb_cases = e_inc_num, ep_tb_cases = new_ep,
                  tidyselect::contains("e_inc_100k"), tidyselect::contains("e_inc_tbhiv_100k")) %>% 
    dplyr::mutate(prop_hiv = e_inc_tbhiv_100k / e_inc_100k,
                  prop_hiv_lo = e_inc_tbhiv_100k_lo / e_inc_100k_hi,
                  prop_hiv_hi = e_inc_tbhiv_100k_hi / e_inc_100k_lo) %>% 
    dplyr::mutate(tb_inc = e_inc_100k, 
                  tb_inc_lo = e_inc_100k_lo,
                  tb_inc_hi = e_inc_100k_hi,
                  prop_tb_ep = ep_tb_cases / tb_cases) %>% 
    dplyr::select(country, iso3, g_whoregion, year, tb_cases, 
                  tidyselect::contains("tb_inc"), prop_tb_ep, tidyselect::contains("prop_hiv")) %>% 
    dplyr::filter(year >= 2000)
  
  if (!is.null(inc_floor)) {
    tb <- tb %>% 
      dplyr::filter(tb_cases >= inc_floor)
  }
  
  if (!is.null(inc_rate_floor)) {
    tb <- tb %>% 
      dplyr::filter(tb_inc >= inc_rate_floor)
  }
  
  return(tb)
}
