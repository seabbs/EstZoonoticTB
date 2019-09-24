#' Status of zoonotic TB in animals
#'
#' Country level data on the status of zoonotic TB in animals (domesticated and wild) for 2018. Data is sourced from the [OIE](https://www.oie.int) 
#' via personal communication. Data cleaning details can be found in [/data-raw/zoonotic_tb_animals.R](https://github.com/seabbs/EstZoonoticTB/blob/master/data-raw/zoonotic_tb_animals.R).
#' @format A data frame with 187 rows and 5 variables.
#' \describe{
#'   \item{country}{Country name (factor)}
#'   \item{country_code}{Country code (factor)}
#'   \item{year}{Year (numeric)}
#'   \item{dom}{Presence of zoonotic TB in  domesticated animals (factor: present; limited; suspected; limited + suspected; not present; NA)}
#'   \item{wild}{Presence of zoonotic TB in wild animals (factor: present; limited; suspected; limited + suspected; not present; NA)}
#' }
"zoonotic_tb_animals"