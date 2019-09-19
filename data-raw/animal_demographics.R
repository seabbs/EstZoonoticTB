# Data info ---------------------------------------------------------------
## THIS IS A PLACEHOLDER FILE - DO NOT USE
## Data downloaded from here: http://www.fao.org/faostat/en/?#data/OA
## Data downloaded on 19/09/19
## Searched for population, selected annual population, and selected all data for downloading. 


# Raw data ----------------------------------------------------------------
library(magrittr)

animal_demographics <- data.table::fread("animal_demographics.csv") %>% 
  tibble::as_tibble()



# Pull out variables of interest ------------------------------------------

animal_demographics <- animal_demographics %>% 
  dplyr::select(country = Area, country_code = `Area Code`,
                type = Element, year = Year, pop = Value)


# Clean data --------------------------------------------------------------

animal_demographics <- animal_demographics %>% 
  dplyr::mutate(country = factor(country),
                pop = pop * 1000) %>% 
  dplyr::filter(type %in% c("Total Population - Both sexes", "Rural population", "Urban population")) %>% 
  tidyr::pivot_wider(
    names_from = c("type"), 
    values_from = "pop"
  ) %>% 
  dplyr::rename(population = `Total Population - Both sexes`, 
                rural = `Rural population`,
                urban = `Urban population`) %>% 
  dplyr::mutate(prop_rural = rural / population) %>% 
  dplyr::select(-urban, -rural) %>% 
  ## Dealing with no ASCII characters in the country names (found via devtools::check)
  dplyr::mutate(country = country %>% 
                  as.character() %>% 
                  replace(country %in% "Réunion", "Reunion") %>% 
                  replace(country %in% "Côte d'Ivoire", "Cote d'Ivoire") %>% 
                  factor())

# Load into package -------------------------------------------------------

usethis::use_data(animal_demographics, overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(animal_demographics, "animal_demographics_clean.csv")
