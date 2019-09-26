#' Generate a global map for a single variable.
#'
#'
#' @description This general purpose function can be used to generate a global map for a single variable. It has few defaults but 
#' the data supplied must contain a \code{country_code} variable (that uses the iso3 standard) for linking to mapping data.
#' @param data Dataframe containing variables to be mapped. Must contain a \code{country_code} variable.
#' This must use iso3 standard country codes. See \code{\link[EstZoonoticTB]{link_data}} for an example dataframe.
#' @param variable A character string indicating the variable to map data for. This must be supplied.
#' @param variable_label A character string indicating the variable label to use. If not supplied then the underlying
#' variable name is used.
#' @param trans A character string specifying the transform to use on the specified metric. Defaults to no 
#' transform ("identity"). Other options include log scaling ("log") and log base 10 scaling
#' ("log10"). For a complete list of options see \code{ggplot2::continous_scale}.
#' @param fill_labels A function to use to allocate legend labels. An example (used below) is \code{scales::percent},
#' which can be used for percentage data.
#' @param viridis_palette Character string indicating the \code{viridis} colour palette to use. Defaults
#' to "cividis". Options include "cividis", "magma", "inferno", "plasma", and "viridis". For additional details 
#' @param show_caption Logical, defaults to \code{TRUE}. Should the default caption be displayed.
#' @seealso link_data
#' @return A \code{ggplot2} object containing a global map.
#' @export
#'
#' @importFrom rnaturalearth ne_countries
#' @importFrom dplyr left_join select filter
#' @importFrom ggplot2 ggplot aes geom_sf theme_minimal theme labs waiver
#' @importFrom rlang .data
#' 
#' @examples
#' 
#' ## Filter data to get the latest study in each country on zTB
#' data <- EstZoonoticTB::link_data(verbose = FALSE) %>% 
#' EstZoonoticTB::get_latest_data(tb_z_prop)
#' 
#' ## Plot a global map of zTB
#' global_map(data, variable = "tb_z_prop", 
#'          variable_label = "% of TB cases that are zoonotic",
#'          trans = "sqrt", fill_labels = scales::percent)
#' 
global_map <- function(data = NULL, variable = NULL,
                     variable_label = NULL,
                     trans = "identity",
                     fill_labels = NULL,
                     viridis_palette = "cividis",
                     show_caption = TRUE) {


# Prep --------------------------------------------------------------------

  country <- NULL; subregion <- NULL;
  
if (is.null(data)) {
    stop("A dataset must be supplied containing at least one variable to map.")
}
  
if (is.null(data$country_code)) {
  stop("A country_code variable must be present in order to link to mapping data.")
}
  
if (is.null(variable)) {
  stop("A variable must be supplied as a character string.")
}
  
if (is.null(variable_label)){
  variable_label <- variable
}  

  
if (is.null(fill_labels)) {
  fill_labels <- ggplot2::waiver()
}
  

# Get shape file ----------------------------------------------------------

  ## Country level
  world <- rnaturalearth::ne_countries(scale='medium',
                                       returnclass = 'sf')
  ## Coastlines
  continents <- rnaturalearth::ne_coastline(scale = "medium", 
                                            returnclass = "sf")


# Link data and shape file ------------------------------------------------

 world_with_data <- suppressWarnings(
   world %>% 
   dplyr::left_join(data %>% 
                      dplyr::select(-country),
                    by = c("iso_a3" = "country_code"))
 )

# Make map ----------------------------------------------------------------


  map <- ggplot2::ggplot(world_with_data) +
    ggplot2::geom_sf(ggplot2::aes(fill = .data[[variable]]), col = "white", size = 0.2) +
    ggplot2::geom_sf(data = continents, col = "darkgrey", alpha = 0.6, size = 0.2) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")

# Add map details ---------------------------------------------------------

  if (show_caption) {
    map <- map +
      ggplot2::labs(
        caption = "Made with {EstZoonoticTB}: See {EstZoonoticTB} for data sources"
      )
  }
  
  if (is.numeric(world_with_data[[variable]])) {
    map <- map +
      ggplot2::guides(fill = ggplot2::guide_colorbar(title = variable_label,
                                                     barwidth = 15, barheight = 0.5)) +
      ggplot2::scale_fill_viridis_c(
        begin = 0,
        end = 0.9,
        trans = trans,
        direction = -1, 
        labels = fill_labels, 
        option = viridis_palette,
        na.value = "lightgrey"
      )
    
  }else{
    map <- map +
      ggplot2::guides(fill = ggplot2::guide_legend(title = variable_label)) +
      ggplot2::scale_fill_viridis_d(
        begin = 0,
        end = 0.9,
        direction = -1, 
        labels = fill_labels, 
        option = viridis_palette,
        na.value = "lightgrey"
      )
  }



# Return map --------------------------------------------------------------

    
  
  return(map)
}