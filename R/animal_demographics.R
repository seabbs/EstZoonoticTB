#' Animal demographic data
#'
#' Country level animal demographic data from 1950 to the current day. Data is sourced from the [FAO](http://www.fao.org/faostat/en/?#data/OA). 
#' Data cleaning details can be found in [/data-raw/animal_demographics.R](https://github.com/seabbs/EstZoonoticTB/blob/master/data-raw/animal_demographics.R).
#' @format A data frame with 14,857 rows and 5 variables.
#' \describe{
#'   \item{country}{Country name (factor)}
#'   \item{country_code}{Country code (numeric)}
#'   \item{year}{Year (numeric)}
#'   \item{population}{Estimated population size (numeric)}
#'   \item{prop_rural}{Proportion of population that is estimated to be rural (numeric)}
#' }
"animal_demographics"