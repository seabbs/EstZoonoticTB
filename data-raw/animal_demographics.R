# Data info ---------------------------------------------------------------
## Data downloaded from here: http://www.fao.org/faostat/en/?#data/OA
## Data downloaded on 20/09/19
## Searched for cattle, selected live animals, and then selected cattle with all years and countries. 


# Raw data ----------------------------------------------------------------
library(magrittr)

animal_demographics <- data.table::fread("animal_demographics.csv") %>% 
  tibble::as_tibble()



# Pull out variables of interest ------------------------------------------

animal_demographics <- animal_demographics %>% 
  dplyr::select(country = Area, country_code = `Area Code`,
                type = Item, year = Year, pop = Value)


# Clean data --------------------------------------------------------------

animal_demographics <- animal_demographics %>% 
  dplyr::mutate(country = factor(country),
                type = type %>% 
                  tolower()) %>% 
  tidyr::pivot_wider(
    names_from = c("type"), 
    values_from = "pop"
  ) %>% 
  ## Dealing with no ASCII characters in the country names (found via devtools::check)
  dplyr::mutate(country = country %>% 
                  as.character() %>% 
                  replace(country %in% "Réunion", "Reunion") %>% 
                  replace(country %in% "Côte d'Ivoire", "Cote d'Ivoire") %>% 
                  factor()) %>% 
  ## Manual link differing country names
  ## Drop regions of china (disputed) - data already included in main china data
  dplyr::filter(!(country %in% c(
    "China, mainland",
    "China, Taiwan Province of"
  ))) %>% 
  dplyr::mutate(
    country = country %>% 
      replace(country %in% "Saint Helena, Ascension and Tristan da Cunha" , "St. Helena") %>% 
      replace(country %in% "Serbia and Montenegro" , "Serbia & Montenegro") %>% 
      replace(country %in% "Netherlands Antilles (former)" , "Netherlands Antilles")
  )


# Load into package -------------------------------------------------------

usethis::use_data(animal_demographics, overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(animal_demographics, "animal_demographics_clean.csv")
