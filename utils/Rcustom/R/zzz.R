.onLoad <- function(libname, pkgname) {
    invisible()
}

.onAttach <- function(libname, pkgname) {
  suppressMessages(library(crayon))
  packageStartupMessage(yellow("Using personal package by Matias Faure"))

  # Global variables
  data_path <<- "assets/data/project/"
  fig_path <<- "assets/figures/"
  tab_path <<- "assets/tables/"
  obj_path <<- "assets/object/"

  # Set ggplot options

  # Set stargazer options

  # Set global variables
  df <<- get_proj_data()
  if (is.list(df) & length(df) == 0) {
    message("No data available in the project's data directory.")
  }
}