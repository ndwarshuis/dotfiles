## .First <- function() {
##  message("R is the best\n","working directory is:", getwd())
## }

## TODO make this find .Rprofiles in parent directories
if ( ".Rprofile" %in% list.files(all.files = TRUE) ) {
    message("Sourcing local .Rprofile")
    source(".Rprofile")
}

## Set CRAN mirror:
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org/"
  options(repos = r, Ncpus = 8)
})
