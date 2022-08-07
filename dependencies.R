#!/usr/bin/env Rscript

require_package_or_stop <- function(package_to_require) {
  result <- suppressMessages(suppressWarnings(
    require(package_to_require, character.only = TRUE, quietly = TRUE)
  ))
  if (!result) {
    stop(paste0("Fail to load", package_to_require))
  }
}

packages_to_require <- c(
  "argparse"
)

for (i in seq_along(packages_to_require)) {
  require_package_or_stop(packages_to_require[i])
}

