#' Run a Zoonotic TB Shiny Dashboard
#'
#' @description This functions runs a Zoonotic TB dashboard that has been built using other
#' package functionality. The dashboard can be used to explore the global burden of Zoonotic TB 
#' interactively. 
#' @return Starts a shiny dashboard
#' @export
#' @importFrom utils installed.packages
#' @examples
#' 
#' ## Only run the example if in an interative session
#' \dontrun{
#' 
#' ## Run the TB dashboard
#' dashboard()
#' }
dashboard <- function() {
  
  required_packages <- c("shiny", "shinydashboard", "shinyWidgets", "shinycssloaders",
                         "plotly", "magrittr", "dplyr", "tibble", "rmarkdown", 
                         "magrittr", "ggplot2", "tidyr", "rlang", "getTBinR", "EstZoonoticTB")

  
  not_present <- sapply(required_packages, function(package) {
    
    not_present <- !(package %in% rownames(installed.packages()))
    
    if (not_present) {
      message(paste0(package,
                  " is required to use run_tb_dashboard, please install it before using this function"))
    }
    
    return(not_present)
  }
  )

  if (any(not_present)) {
    stop("Packages required for this dashboard are not installed, 
         please use the following code to install the required packages \n\n 
         install.packages(c('", paste(required_packages[not_present], collapse = "', '"), "'))")
  }
  
  appDir <- system.file("shiny", "ExploreZoonoticTB", package = "EstZoonoticTB")
  if (appDir == "") {
    stop("Could not find the ExploreZoonoticTB directory. Try re-installing `EstZoonoticTB`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
