# Data info ---------------------------------------------------------------

## Data downloaded from here: 
## Data downloaded on 20/09/19
## Searched for population, selected annual population, and selected all data for downloading. 


# Raw data ----------------------------------------------------------------
library(magrittr)

zoonotic_tb_humans <- data.table::fread("zoonotic_tb_humans .csv") %>% 
  tibble::as_tibble()



# Pull out variables of interest ------------------------------------------

zoonotic_tb_humans  <- zoonotic_tb_humans  %>% 
  dplyr::select(country = Area, country_code = `Area Code`,
                type = Element, year = Year, pop = Value)


# Clean data --------------------------------------------------------------


# Load into package -------------------------------------------------------

usethis::use_data(zoonotic_tb_humans , overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(zoonotic_tb_humans, "zoonotic_tb_humans _clean.csv")