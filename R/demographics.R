#' Demographic data
#'
#' Country level demographic data from 1950 to the current day. Also includes the proportion of the population
#' that are rural. Data is sourced from the [FAO](http://www.fao.org/faostat/en/?#data/OA). 
#' Data cleaning details can be found in [/data-raw/demographics.R](https://github.com/seabbs/EstZoonoticTB/blob/master/data-raw/cleaning.R).
#' @format A data frame with 14,857 rows and 5 variables.
#' \describe{
#'   \item{country}{Country name (factor)}
#'   \item{country_code}{Country code (numeric)}
#'   \item{year}{Year (numeric)}
#'   \item{population}{Estimated population size (numeric)}
#'   \item{prop_rural}{Proportion of population that is estimated to be rural (numeric)}
#' }
"demographics"