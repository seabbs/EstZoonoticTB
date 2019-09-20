# Data info ---------------------------------------------------------------

## Data downloaded from here: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/
## Data downloaded on 20/09/19



# Raw data ----------------------------------------------------------------
library(magrittr)

zoonotic_tb_humans <- readxl::read_excel("zoonotic_tb_humans.xlsx",
                                         sheet = 2, skip = 2)




# Pull out variables of interest ------------------------------------------

zoonotic_tb_humans  <- zoonotic_tb_humans  %>% 
  dplyr::select(id = `Data point...1`,
                study_id = `Record ID`, country = Setting,
                geo_coverage = `Geographical range`, 
                pop_coverage = `Population coverge`,
                study_pop = `Study population`,
                sampling_strat = `Sampling strategy`,
                age = `Age group`,
                gender = Gender,
                study_period = `Study period`,
                cases = Cases,
                sample_size = Tested,
                pop_size = `Population size`,
                inc_rate = `Inc rate`,
                ztb_prop_tb = `% of TB`)


# Initial data clean ------------------------------------------------------

zoonotic_tb_humans  <- zoonotic_tb_humans %>% 
  ## Covert all -9 into NAs
  dplyr::mutate_all(~ ifelse(. == -9, NA, .)) %>% 
  ## Pull out country name (assuming before first comma)
  dplyr::mutate(country = country %>% 
                  stringr::str_split(", ") %>% 
                  purrr::map_chr(dplyr::first) %>% 
                  replace(country %in% "Côte d'Ivoire", "Cote d'Ivoire")) %>% 
  ## Extract study end by assuming that it is the last 4 digits. (remove brackets to be sure).
  ## Dropping nonsense date.
  dplyr::mutate(study_end = study_period %>% 
                  stringr::str_replace("\\)", "") %>% 
                  stringr::str_sub(start =-4) %>% 
                  as.numeric %>% 
                  {ifelse(. == 4394, NA, .)}) %>% 
  dplyr::mutate_if(is.character, factor)

summary(zoonotic_tb_humans)


# Explore data levels -----------------------------------------------------

## Age
levels(zoonotic_tb_humans$age)

## Gender
levels(zoonotic_tb_humans$gender)

## Study population
levels(zoonotic_tb_humans$study_pop)

# Exclusions --------------------------------------------------------------

zoonotic_tb_humans <- zoonotic_tb_humans %>%
  ## Keep studies that were in all age groups (or unknown) only
  dplyr::filter(age %in% "All/Unknown") %>% 
  ## Keep studies in both genders (or unknown only)
  dplyr::filter(gender %in% "Both/Unknown")


# Load into package -------------------------------------------------------

usethis::use_data(zoonotic_tb_humans , overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(zoonotic_tb_humans, "zoonotic_tb_humans _clean.csv")