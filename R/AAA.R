

nlp <- new.env()

.onLoad <- function(libname, pkgname) {
  packageStartupMessage("- Connecting/Setting up Python using reticulate")
  reticulate::configure_environment(pkgname)
  packageStartupMessage("- Loading golgotha BERT code")
  pyscript <- system.file(package = "golgotha", "python", "BERT.py")
  source_python(pyscript, envir = nlp, convert = TRUE)
}


#' @import reticulate
NULL
