.onLoad <- function(libname, pkgname) {
    invisible()
}

.onAttach <- function(libname, pkgname) {
  suppressMessages(library(crayon))
  packageStartupMessage(yellow("Using personal package by Matias Faure"))

  project_name <- Sys.getenv("PROJECT_NAME")

  # Global variables
  data_path <<- paste0(project_name, "/assets/data/project/")
  fig_path <<- paste0(project_name, "/assets/figures/")
  tab_path <<- paste0(project_name, "/assets/tables/")
  obj_path <<- paste0(project_name, "/assets/objects/")

  # Set ggplot options
  # Set stargazer options

  # Set global variables
  data <<- get_proj_data()
  if (is.list(data) & length(data) == 0) {
    message("No data available in the project's data directory.")
  }
}