unlink_model_directory <- function(){
  d <- system.file(package = "golgotha", "models")
  d <- setdiff(list.dirs(d), d)
  unlink(d, recursive = TRUE)
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
    tinytest::run_test_file(file = file.path(testdir, "test-download.R"))
    unlink_model_directory()
    tinytest::run_test_file(file = file.path(testdir, "test-transformer-default.R"))
    unlink_model_directory()
    tinytest::run_test_file(file = file.path(testdir, "test-distilbert.R"))
    unlink_model_directory()
  }
}
