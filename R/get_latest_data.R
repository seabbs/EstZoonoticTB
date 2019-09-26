#' Extract the Latest Data for a Variable
#'
#'
#' @description This conveniance function works with output from \code{[EstZoonoticTB]{link_data}} to extract
#' the most recent data from each country for a given variable
#' @param variable An unquoted variable name to select the most recent data for.
#' @return A tibble containing the most recent estimates, by country, of the proportion of TB cases that are zoonotic
#' @export
#'
#' @inheritParams global_map
#' @importFrom dplyr mutate filter group_by arrange slice ungroup
#' @importFrom rlang enquo !!
#' @examples
#' 
#' 
#' ## Extract linked data
#' df <- link_data(verbose = FALSE)
#' 
#' ## Extract most recent study data
#' get_latest_data(df, tb_z_prop)

get_latest_data <- function(data, variable = NULL) {
  
  country <- NULL; year <- NULL; desc <- NULL;
  
  variable <- rlang::enquo(variable)
  
  data %>% 
    dplyr::mutate(country = country %>% 
                    as.character) %>% 
    dplyr::filter(!is.na(!!variable)) %>% 
    dplyr::group_by(country) %>% 
    dplyr::arrange(desc(year)) %>% 
    dplyr::slice(1) %>% 
    dplyr::ungroup()
  
}
