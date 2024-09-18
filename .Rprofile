if (interactive()) {
    options(max.print = 100)
    options(startup.quiet = FALSE)
    suppressMessages(require(devtools))
    load_all("utils/Rcustom", quiet = TRUE)
}

.First <- function() {
  if (file.exists("custom_workspace.RData")) {
    load("custom_workspace.RData", envir = .GlobalEnv)
  }
}

.Last <- function() {
  save.image("custom_workspace.RData")
}
