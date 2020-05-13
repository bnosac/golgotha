if(requireNamespace("tinytest", quietly = TRUE)){
  if(tinytest::at_home()){
    library(golgotha)
    tinytest::test_package("golgotha")
  }
}
