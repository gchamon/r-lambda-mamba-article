#!/usr/bin/env Rscript

source("dependencies.R")

argument_parser <- ArgumentParser()
argument_parser$add_argument("--names-to-greet", type = "character", nargs = "+")
args <- argument_parser$parse_args()

echo <- function(string) {
  cat(paste0(string, "\n"))
}

for (name_to_greet in args$names_to_greet){
  echo(paste0("Hello ", name_to_greet, "!"))
}
