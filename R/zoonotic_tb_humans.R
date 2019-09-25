#' Status of zoonotic TB in humans
#'
#' Country level data on the status of zoonotic TB in humans across multiple years. Data is sourced from [this systematic review](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4816377/).
#' via personal communication. Data cleaning details can be found in [\\\\data-raw\\\\zoonotic_tb_humans.R](https://github.com/seabbs/EstZoonoticTB/blob/master/data-raw/zoonotic_tb_humans.R).
#' @format A data frame with 201 rows and 16 variables.
#' \describe{
#'   \item{id}{Unique clean dataset id (numeric)}
#'   \item{study_id}{Unique study id (numeric)}
#'   \item{dirty_id}{Unique raw dataset id (numeric)}
#'   \item{country}{Country name}
#'   \item{geo_coverage}{Geographical coverage of study (factor)}
#'   \item{study_pop}{Population included in the study (factor)}
#'   \item{sampling_strat}{Sampling strategy used by the study (factor)}
#'   \item{study_period}{Time period the study covered (character)}
#'   \item{study_end}{Year that the study ended/reported (numeric)}
#'   \item{multi_year_study}{Is the study multi-year (factor: yes; no)}
#'   \item{cases}{Number of zoonotic TB cases reported (numeric)}
#'   \item{sample_size}{Number of TB cases included in the study (numeric)}
#'   \item{tb_z_prop }{Proportion of TB cases that are zoonotic (numeric)}
#'   \item{tb_z_prop_lo}{Lower bound (95\\% CI) proportion of TB cases that are zoonotic (numeric)}
#'   \item{tb_z_prop_hi}{Upper bound (95\\% CI) proportion of TB cases that are zoonotic (numeric)}
#'   \item{tb_z_prop_se}{Standard error of the  proportion of TB cases that are zoonotic (numeric)}
#' }
"zoonotic_tb_humans"