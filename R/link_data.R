#' Link Zoonotic TB Relevant Data
#'
#'
#' @description Link data relevant to zoonotic TB data. Data is linking process 
#' maximises preserved data so any analysis with this data may need additional exclusions
#' and/or munging.
#' 
#' @param z_tb_humans Data on zoonotic TB in humans - formated as `EstZoonoticTB::zoonotic_tb_humans`. 
#' Defaults to `EstZoonoticTB::zoonotic_tb_humans`.
#' @param tb_humans Data on  TB in humans - formated as `EstZoonoticTB::tb_data()`. 
#' Defaults to `EstZoonoticTB::tb_data()`.
#' @param z_tb_animals Data on zoonotic TB in animals - formated as `EstZoonoticTB::zoonotic_tb_animals`. 
#' Defaults to `EstZoonoticTB::zoonotic_tb_humans`. 
#' @param demo Data on demographics - formated as `EstZoonoticTB::demographics`. 
#' Defaults to `EstZoonoticTB::demographics`.
#' @param animal_demo Data on demographics in animals - formated as `EstZoonoticTB::animal_demographics`. 
#' Defaults to `EstZoonoticTB::animal_demographics`.
#' @param verbose Logical, defaults to \code{TRUE}. Should verbose progress messages be shown.
#'
#' @importFrom dplyr mutate select filter full_join pull rename vars
#' @importFrom tidyselect everything
#' @return A dataframe of linked data containing all available global data relevant to zTB in humans.
#' @export
#'
#' @examples
#' 
#' 
#' ## Linked data relying on package defaults
#' link_data()
link_data <- function(z_tb_humans = NULL, tb_humans = NULL, z_tb_animals = NULL,
                      demo = NULL, animal_demo = NULL,
                      verbose = TRUE) {
  
  
  
  
  # Use default data if none is supplied ------------------------------------
  
  if (is.null(z_tb_humans)) {
    z_tb_humans <- EstZoonoticTB::zoonotic_tb_humans
  }
  
  if (is.null(tb_humans)) {
    tb_humans <- EstZoonoticTB::tb_data(verbose = FALSE)
  }
  
  
  if (is.null(z_tb_animals)) {
    z_tb_animals <- EstZoonoticTB::zoonotic_tb_animals
  }
  
  if (is.null(demo)) {
    demo <- EstZoonoticTB::demographics
  }
  
  if (is.null(animal_demo)) {
    animal_demo <- EstZoonoticTB::animal_demographics
  }
  
  
  # Join demographic data ---------------------------------------------------
  
  ## Check levels
  
  if (verbose) {
    message("Joining human and animal demographic data.")
    
    message("Countries with data present for demographics and not animal demographics:")
    print(setdiff(demo$country, animal_demo$country))
    
    
    message("Countries with data present for animal demographics and not demographics:")
    print(setdiff(animal_demo$country, demo$country))
  }
  
  ## Suppress warnings for factors forced to character
  ## Full join for all data. 
  demo <- suppressWarnings(
    demo %>% 
      dplyr::full_join(animal_demo, 
                       by = c("country", "year", "country_code"))
  )
  
  ## Add animals per head
  
  demo <- demo %>% 
    dplyr::mutate(cattle_per_head = cattle / population)
  
  # Join TB data and zTB in animals data ------------------------------------
  
  if (verbose) {
    message("Joining TB incidence in humans data and zTB presence in animals data.")
    
    message("Countries with data present for TB incidence and not zTB in animals:")
    tb_not_animal_tb <- tb_humans %>% 
      dplyr::filter(iso3 %in% setdiff(tb_humans$iso3, z_tb_animals$country_code)) %>% 
      dplyr::pull(country) %>% 
      as.character %>% 
      unique 
    
    print(tb_not_animal_tb)
    
    
    message("Countries with data present for zTB in animals and not TB incidence:")
    animal_tb_not_tb <- z_tb_animals %>% 
      dplyr::filter(country_code %in% setdiff(z_tb_animals$country_code, tb_humans$iso3)) %>% 
      dplyr::pull(country) %>% 
      as.character %>% 
      unique
    
    print(animal_tb_not_tb)
  }
  
  ## Join using a full join on country code and year
  ## assume that TB data country name is correct and replace with 
  ## zTB in animals country name if missing.
  joined_tb <- suppressWarnings(
    tb_humans %>% 
    dplyr::rename(country_code = iso3) %>% 
    dplyr::full_join(z_tb_animals, by = c("country_code", "year")) 
  ) %>% 
    dplyr::mutate(country = ifelse(!is.na(country.x), 
                                   as.character(country.x), 
                                   as.character(country.y))) %>% 
    dplyr::select(-country.x, -country.y) %>% 
    dplyr::select(country, tidyselect::everything())
  
  
  

# Join zTB data to other TB data ------------------------------------------
  
  if (verbose) {
    message("Joining zTB incidence in humans data and all other TB data")
  }
  
  z_tb_not_other_tb <- z_tb_humans %>% 
    dplyr::filter(country %in% setdiff(z_tb_humans$country, joined_tb$country)) %>% 
    dplyr::pull(country) %>% 
    as.character %>% 
    unique 
  
  ## Check countries are listed in general TB dataset. 
  if (length(z_tb_not_other_tb) > 0) {
    stop("The following countries in the zTB dataset do not match with countries in other TB datasets: ",
         paste(z_tb_not_other_tb, collapse = ", "),
         "\n Adjust data inputs and rerun this funciton.")
  }

  
  ## Joining datasets
  ## Dropping not essential zTB data
  joined_tb <- suppressWarnings(
    joined_tb %>% 
    dplyr::full_join(z_tb_humans %>% 
                    dplyr::rename(year = study_end) %>% 
                    dplyr::rename_at(.vars = dplyr::vars(id, geo_coverage,
                                                         study_pop, multi_year_study
                                                         ),
                                     ~ paste0("z_tb_", .)) %>% 
                dplyr::select(-study_id, -dirty_id,
                              -cases, -sample_size, -study_period, 
                              -sampling_strat),
              by = c("country", "year"))
  )
  
  
# Join TB data to demographic data ----------------------------------------

  
  setdiff(unique(joined_tb$country), unique(demo$country))
  
  
  setdiff(unique(demo$country), unique(joined_tb$country))
  
# Define returned objects -------------------------------------------------
  

  out <- joined_tb
  
  return(out)
}