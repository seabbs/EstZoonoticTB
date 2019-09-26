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
                tb_cases = `TB inc`,
                pop = `Population size`,
                inc_rate = `Inc rate`,
                ztb_prop_tb = `% of TB`)


# Initial data clean ------------------------------------------------------

zoonotic_tb_humans  <- zoonotic_tb_humans %>% 
  ## Evaluate if studies are multiple years 
  dplyr::mutate(multi_year_study = study_period %>% 
                  as.numeric %>% 
                  is.na %>% 
                  {ifelse(., "yes", "no")}) %>% 
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
  dplyr::mutate_if(is.character, factor) %>% 
  ## Replace countries that have NA incidence rates with 0 if cases are recorded as zero
  dplyr::mutate(inc_rate = replace(inc_rate, cases == 0, 0))

summary(zoonotic_tb_humans)


# Explore data levels -----------------------------------------------------

## Countries
summary(zoonotic_tb_humans$country)

3## Age
levels(zoonotic_tb_humans$age)

## Gender
levels(zoonotic_tb_humans$gender)

## Study population
levels(zoonotic_tb_humans$study_pop)

## Population coverage
summary(factor(zoonotic_tb_humans$pop_coverage))

## Explore geo coverage
summary(zoonotic_tb_humans$geo_coverage)


## Explore data from the United states of america
usa_df <- zoonotic_tb_humans %>%
  dplyr::filter(country %in% "United States of America")

usa_df

## Explore studies that are missing both sample size and number of TB cases. 
zoonotic_tb_humans %>% 
  dplyr::filter(is.na(tb_cases) & is.na(sample_size))

# Exclusions --------------------------------------------------------------

zoonotic_tb_humans <- zoonotic_tb_humans %>%
  ## Fold TB cases into sample size
  dplyr::mutate(sample_size = ifelse(is.na(sample_size), tb_cases, sample_size)) %>% 
  ## If cases are unknown attempt to find by using sample_size and ztb_prop_tb
  dplyr::mutate(cases = ifelse(is.na(cases), sample_size * ztb_prop_tb, cases)) %>% 
  ##Drop data with an unknown study period
  dplyr::filter(!is.na(study_period)) %>% 
  ## Drop data from across the EU as a whole
  ## Drop data from the USA due to extreme low quality.
  dplyr::filter(!(country %in% c(
    "European Union",
    "United States of America")
    )) %>% 
  ## Keep studies that were in all age groups (or unknown) only
  dplyr::filter(age %in% "All/Unknown") %>% 
  dplyr::select(-age) %>% 
  ## Keep studies in both genders (or unknown only)
  dplyr::filter(gender %in% "Both/Unknown") %>% 
  dplyr::select(-gender) %>% 
  ## Keep studies that looked at the general population,
  ## identified TB cases, hospital population
  dplyr::filter(pop_coverage %in% c("General population",
                                    "Identified TB cases", 
                                    "Hospital population",
                                    "Hospital population, identified TB cases",
                                    "General population, hospital population")) %>% 
  ## If a  country has routine national surveillance data then drop other sources.
  ## Do this by filtering out studies that don't cover the country level population
  ## country level data is present.
  {dplyr::filter(., !(
    (geo_coverage %in% c("Non-country-wide data", "Unknown origin")) &
      (country %in% (dplyr::filter(., geo_coverage %in% "Country-wide data") %>% 
      dplyr::pull(country) %>% 
      unique() %>% 
      as.character))
    )
  )} %>% 
  ## If a study has data on identified TB cases then drop the data on the general population as this is a duplicate record.
  {dplyr::anti_join(
    dplyr::mutate(., 
           pop_coverage = as.character(pop_coverage)),
           dplyr::select(., study_id, country, study_period,
                         geo_coverage, pop_coverage) %>% 
             dplyr::filter(pop_coverage %in% "Identified TB cases") %>% 
             dplyr::mutate(pop_coverage = "General population"),
           by = c("study_id", "country", "geo_coverage", "pop_coverage", "study_period"))
    
  } %>% 
  ##Similarly if a study has data on a hospitalised TB cases then drop data on general hospital population
  {dplyr::anti_join(
    dplyr::mutate(., 
           pop_coverage = as.character(pop_coverage)),
    dplyr::select(., study_id, country, study_period,
                  geo_coverage, pop_coverage) %>% 
      dplyr::filter(pop_coverage %in% "Hospital population, identified TB cases") %>% 
      dplyr::mutate(pop_coverage = "General population, hospital population"),
    by = c("study_id", "country", "geo_coverage", "pop_coverage", "study_period"))
    
  } %>% 
  ## Drop all studies that don't list a sample size or number of TB cases
  ## This may be a little restrictive as some population level studies appear to use population as a 
  ## baseline measure. Manual inspection of this would be required.
  dplyr::filter(!(is.na(tb_cases) & is.na(sample_size))) %>% 
  dplyr::mutate_if(is.factor, forcats::fct_drop)


## Data cleaning is split here after removing most duplicate records etc +
## Dropping non-country wide data when country wide data was present to make
## manual inspection easier

# Country wide data -------------------------------------------------------

country_wide <- zoonotic_tb_humans %>% 
  dplyr::filter(geo_coverage %in% "Country-wide data") %>% 
  dplyr::mutate_if(is.factor, forcats::fct_drop)

## Inspect study populations for exclusion.
levels(country_wide$study_pop)

## Exclusion reasons: 
## * Study in subpopulation
## * Study in higher risk population

country_wide <- country_wide %>% 
  dplyr::filter(!(study_pop %in% c(
    "TB patients with isolates different from M. tuberculosis and submited to the Helio Fraga National Reference Laboratory",
    "TB cases investigated by the National surveys for drug resistance", 
    "TB cases in the southern part captured by New Zealand's three referral laboratories for TB",
    "TB cases in the northern part captured by New Zealand's three referral laboratories for TB",
    "TB cases in the native population captured by New Zealand's three referral laboratories for TB",
    "TB cases in the foreign-born population captured by New Zealand's three referral laboratories for TB",
    "Pacific TB cases captured by New Zealand's three referral laboratories for TB",
    "Other TB cases captured by New Zealand's three referral laboratories for TB",
    "Multidrug-restistant (MDR) TB patients from 118 mycobacteriology laboratories located within different hospitals in Spain; MDR = resistant to isoniazid and rifampin",
    "TB cases analyzed by the Central Veterinary Laboratory (LVC) and the nationwide survey for drug resistance", 
    "Maori TB cases captured by New Zealand's three referral laboratories for TB",
    "European TB cases captured by New Zealand's three referral laboratories for TB",
    "TB patients detected in England",
    "TB patients with confirmed M. tuberculosis complex infection")))


## Pull out New Zealand for further inspection
nz_check <- country_wide %>% 
  dplyr::filter(country %in% c("New Zealand"))

## NZ has repeat sample sizes values that are clearly incorrect and 
## a duplicate of the same study. Drop both
country_wide <- country_wide %>% 
  dplyr::filter(!(country %in% "New Zealand" & 
                    (sample_size == 169 | study_period %in% "1998-2002"))) %>% 
  dplyr::select(-pop_coverage, -tb_cases, -pop, -inc_rate, -ztb_prop_tb) %>%  
  dplyr::mutate_if(is.factor, forcats::fct_drop)


## Inspect based on repeated study end dates and country
dup_countries <- dplyr::count(country_wide, country, study_end) %>%
  dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n > 1) %>% 
  dplyr::pull(country) %>% 
  as.character


dup_country_df <- country_wide %>% 
  dplyr::filter(country %in% dup_countries)
  
## Exclude duplicate entries for France
## Exclude non culture complete data for ireland to avoid duplicates

country_wide <- country_wide %>% 
  dplyr::filter(!(study_pop %in% c("TB culture positive cases reported in France in that year",
                                 "Culture-confirmed TB cases") &
                  country %in% "France")) %>% 
  dplyr::filter(!(study_pop %in% c("Culture-confirmed TB cases tested for the presence of M. bovis")&
                    country %in% "Ireland"))
  

## Manual check all remaining study populations that are not Country-wide detected TB cases

non_standard_study_pop <- country_wide %>% 
  dplyr::filter(!(study_pop %in% c("Country-wide detected TB cases")))


## Finalise country wide data and check

country_wide <-  country_wide %>%  
  dplyr::select(id, study_id, country, geo_coverage,
                study_pop, sampling_strat, study_period,
                study_end, multi_year_study, cases, sample_size) %>% 
  dplyr::mutate_if(is.factor, forcats::fct_drop)

summary(country_wide)
  
# Non-country wide data ---------------------------------------------------

## WARNING: This data is very low quality - needs to be handled with care.

non_country_wide <- zoonotic_tb_humans %>% 
  dplyr::filter(!(geo_coverage %in% "Country-wide data")) %>% 
  dplyr::mutate_if(is.factor, forcats::fct_drop)


## Inspect study populations for exclusion.
levels(non_country_wide$study_pop)

## No studies excluded here to preserve sample size.
## Kept studies in extra-pulmonary, or pulmonary etc to avoid excluding useful data
## This bias needs to be considered when modelling. 


## ## Inspect based on repeated study period and country

dup_countries <- non_country_wide %>% 
 dplyr::count(country, study_id, study_period) %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::filter(n > 1) %>% 
  dplyr::pull(country) %>% 
  unique

dup_country_df <- non_country_wide %>% 
  dplyr::filter(country %in% dup_countries)


## Exclude duplicate study from Sierre Leone (id: 550; study_id: 12)
## Exclude a duplicate Argentinan study id via study pop
non_country_wide <- non_country_wide %>% 
  dplyr::filter(id != 550) %>% 
  dplyr::filter(!(study_pop %in% "Patients with diagnosis of pulmonary TB, collected at ‘‘Emilio Coni’’ National Institute of Respiratory Diseases"))

## Final manual data cleaning check
non_country_wide

## Exclude a study due to missing study period
non_country_wide <- non_country_wide %>% 
  dplyr::filter(id != 1373)

## Finalise country wide data and check

non_country_wide <-  non_country_wide %>%  
  dplyr::select(id, study_id, country, geo_coverage,
                study_pop, sampling_strat, study_period,
                study_end, multi_year_study, cases, sample_size) %>% 
  dplyr::mutate_if(is.factor, forcats::fct_drop)

summary(non_country_wide)




# Join data sources -------------------------------------------------------

## rebase id
zoonotic_tb_humans <- country_wide %>% 
  dplyr::bind_rows(non_country_wide) %>% 
  dplyr::mutate_if(is.character, factor) %>% 
  dplyr::mutate(dirty_id = id, id = 1:dplyr::n()) %>% 
  dplyr::select(id, study_id, dirty_id, tidyselect::everything())



# Generate outcome variables ----------------------------------------------

zoonotic_tb_humans <- zoonotic_tb_humans %>%
  dplyr::mutate(prop_test = purrr::map2(cases, sample_size, ~ stats::prop.test(.x, .y))) %>% 
  dplyr::mutate(tb_z_prop = purrr::map_dbl(prop_test, ~ .$estimate),
                tb_z_prop_lo = purrr::map_dbl(prop_test, ~ .$conf.int[1]),
                tb_z_prop_hi = purrr::map_dbl(prop_test, ~ .$conf.int[2]),
                tb_z_prop_se = (tb_z_prop_hi - tb_z_prop_lo) / (2 * qnorm(0.975))
                ) %>% 
  dplyr::select(-prop_test) %>% 
  dplyr::mutate(country = country %>% 
                  as.character %>% 
                  replace(country %in% "Côte d'Ivoire" , "Cote d'Ivoire") %>% 
                  replace(country %in% "Czech Republic", "Czechia") %>% 
                  replace(country %in% "Tanzania", "United Republic of Tanzania") %>% 
                  replace(country %in% "Liechtenstein, Principality of" , "Liechtenstein") %>% 
                  factor)

summary(zoonotic_tb_humans)

# Load into package -------------------------------------------------------

usethis::use_data(zoonotic_tb_humans, overwrite = TRUE)


# Save into data-raw in csv format ----------------------------------------

data.table::fwrite(zoonotic_tb_humans, "zoonotic_tb_humans_clean.csv")
