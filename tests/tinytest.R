if(requireNamespace("tinytest", quietly = TRUE)){
  if(tinytest::at_home()){
    library(golgotha)
    tinytest::test_package("golgotha")
    unlink_golgotha()
  }
  if(identical(Sys.getenv("TT_AT_CI"), "TRUE")){
    library(golgotha)
    #tinytest::test_package("golgotha", pattern = "test-check.R|test-transformer-default.R|test-distilbert.R")
    tests <- c("test-distilbert.R", "test-download.R", "test-gpt2.R",
               "test-roberta.R", "test-transformer-default.R", "test-transformer-xl.R",
               "test-xlm-roberta.R", "test-xlm.R", "test-xlnet.R")
    tests <- c("test-download.R", "test-transformer-default.R")
    tinytest::test_package("golgotha", pattern = paste(tests, collapse = "|"))
    unlink_golgotha()
  }
}
