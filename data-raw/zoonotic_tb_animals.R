# Data info ---------------------------------------------------------------

## Data downloaded from recived via private email from OIE
## Data sourced from here: https://www.oie.int
## Data recieved on the 18/09/19.
## Data dictionary at: zoonotic_tb_animals_dictionary.docx

## COMMMENT: THIS DATA IS EXTREMELY LOW QUALITY - HANDLE WITH CARE

# Raw data ----------------------------------------------------------------
library(magrittr)

zoonotic_tb_animals <- data.table::fread("zoonotic_tb_animals.csv") %>% 
  tibble::as_tibble()



# Pull out variables of interest ------------------------------------------

zoonotic_tb_animals <- zoonotic_tb_animals %>% 
  dplyr::select(country = name, country_code = countryid, year = reportperiod, 
                status_DOM, lastdate_DOM, status_WILD, 
                lastdate_WILD)



# Clean data --------------------------------------------------------------

zoonotic_tb_animals <- zoonotic_tb_animals %>% 
  dplyr::mutate(half = year %>% 
                  stringr::str_remove("2018"),
                year = year %>%
                  stringr::str_trunc(width = 4, ellipsis = "")) %>% 
  tidyr::pivot_longer(
    cols = status_DOM:lastdate_WILD,
    names_to = c("type", "animal"),
    values_to = c("count"),
    names_sep = "_"
  ) %>% 
  tidyr::pivot_wider(names_from = "type",
                     values_from = "count") %>% 
  dplyr::mutate(animal = tolower(animal)) %>% 
  ## Dates dropped here may contain some information but 
  ## are so dirty that cleaning them is difficult. 
  ## Add in here if required for analysis.
  dplyr::select(-lastdate) %>% 
  ## Here the data dictionary has been used to map fields to more sensible values.
  dplyr::mutate(
    present = dplyr::case_when(
      purrr::map_lgl(status, ~ grepl("\\+", .)) ~ "yes",
      purrr::map_lgl(status, ~ grepl("\\-", .)) ~ "no",
      TRUE ~ NA_character_),
    suspected_present = dplyr::case_when(
      purrr::map_lgl(status, ~ grepl("\\?", .)) ~ "yes",
      purrr::map_lgl(status, ~ grepl("\\.\\.\\.", .)) ~ NA_character_,
      TRUE ~ "no"),
    limited_present = dplyr::case_when(
      purrr::map_lgl(status, ~ grepl("\\(\\)", .)) ~ "yes",
      purrr::map_lgl(status, ~ grepl("\\.\\.\\.", .)) ~ NA_character_,
      TRUE ~ "no"),
    ) %>% 
  ## Combine these variables into a single variable
  dplyr::mutate(
    zoonotic_tb = dplyr::case_when(
      present %in% "yes" & suspected_present %in% "no" & limited_present %in% "no" ~ "present",
      present %in% "yes" & suspected_present %in% "yes" & limited_present %in% "no" ~ "suspected",
      present %in% "yes" & suspected_present %in% "no" & limited_present %in% "yes" ~ "limited",
      present %in% "yes" & suspected_present %in% "yes" & limited_present %in% "yes" ~ "suspected + limited",
      present %in% "no" & suspected_present %in% "no" & limited_present %in% "no" ~ "not present",
      TRUE ~ NA_character_)
  )

  ## Check status matches data dictionary
  if (interactive()) {
    View(zoonotic_tb_animals)
  }

# Finalise variables ------------------------------------------------------

zoonotic_tb_animals <- zoonotic_tb_animals %>% 
  dplyr::select(tidyselect::contains("country"), year, half, animal, zoonotic_tb) %>% 
  dplyr::mutate_at(.vars = dplyr::vars(year, half), as.numeric) %>% 
  dplyr::mutate_if(is.character, factor)



# Spread into animal status and merge across time -------------------------

## Assumes that any observation counts equally with any other.

zoonotic_tb_animals <- zoonotic_tb_animals %>% 
  tidyr::pivot_wider(names_from = half,
                     values_from = "zoonotic_tb") %>% 
  dplyr::mutate(present = dplyr::case_when(`1` %in% "present" | `2` %in% "present"  ~  "present",
                                           `1` %in% "limited" | `2` %in% "limited" ~ "limited",
                                           `1` %in% "suspected" | `2` %in% "suspected" ~ "suspected",
                                           `1` %in% "suspected + limited" | `2` %in% "suspected + limited" ~ "suspected + limited",
                                           `1` %in% "not present" | `2` %in% "not present" ~ "not present") %>%
           factor) %>% 
  dplyr::select(-`1`, -`2`) %>% 
  tidyr::pivot_wider(names_from = animal,
                     values_from = "present",
                     names_prefix = "") %>% 
  dplyr::mutate(country = country %>% 
                  as.character %>% 
                  replace(country %in% "Côte d'Ivoire" , "Cote d'Ivoire") %>% 
                  replace(country %in% "Czech Republic", "Czechia") %>% 
                  replace(country %in% "Tanzania", "United Republic of Tanzania") %>% 
                  replace(country %in% "Liechtenstein, Principality of" , "Liechtenstein") %>% 
                  factor)

  
# Load into package -------------------------------------------------------

usethis::use_data(zoonotic_tb_animals, overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(zoonotic_tb_animals, "zoonotic_tb_animals_clean.csv")