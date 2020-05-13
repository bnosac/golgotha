if(requireNamespace("tinytest", quietly = TRUE)){
  if(tinytest::at_home()){
    tinytest::test_package("golgotha")
  }
}
