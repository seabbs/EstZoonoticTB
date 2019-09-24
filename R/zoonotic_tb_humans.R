#' Status of zoonotic TB in humans
#'
#' Country level data on the status of zoonotic TB in humans across multiple years. Data is sourced from [this systematic review](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/).
#' via personal communication. Data cleaning details can be found in [/data-raw/zoonotic_tb_humans.R](https://github.com/seabbs/EstZoonoticTB/blob/master/data-raw/zoonotic_tb_humans.R).
#' @format A data frame with 201 rows and 12 variables.
#' \describe{
#'   \item{id}{}
#'   \item{study_id}{}
#'   \item{dirty_id}{Y}
#'   \item{country}{}
#'   \item{geo_coverage{}
#'   \item{study_pop}{}
#'   \item{sampling_strat}{}
#'   \item{study_period}{}
#'   \item{study_end}{}
#'   \item{multi_year_study}{}
#'   \item{cases}{}
#'   \item{sample_size}{}
#' }
"zoonotic_tb_humans"