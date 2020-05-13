unlink_model_directory <- function(){
  d <- system.file(package = "golgotha", "models")
  d <- setdiff(list.dirs(d), d)
  invisible(unlink(d, recursive = TRUE))
}

if(requireNamespace("tinytest", quietly = TRUE)){
  if(tinytest::at_home()){
    library(golgotha)
    tinytest::test_package("golgotha")
    unlink_model_directory()
  }
  if(identical(Sys.getenv("TT_AT_CI"), "TRUE")){
    library(golgotha)
    testdir <- system.file("tinytest", package = "golgotha")
    #tinytest::test_package("golgotha", pattern = "test-check.R|test-transformer-default.R|test-distilbert.R")
    tinytest::test_package("golgotha", pattern = "test-check.R")
    unlink_model_directory()
  }
}
