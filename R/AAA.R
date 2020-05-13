

local <- new.env()

.onAttach <- function(libname, pkgname){
  if(grepl(x = R.Version()$arch, pattern = "32")){
    stop("This package only works on 64bit architectures due to a dependency on torch")
  }
}

.onLoad <- function(libname, pkgname) {
  #packageStartupMessage("- Connecting/Setting up Python using reticulate")
  reticulate::configure_environment(pkgname)
  #packageStartupMessage("- Loading golgotha BERT code")

  oldwd <- getwd()
  on.exit(setwd(oldwd))
  setwd(system.file(package = "golgotha", "python"))
  nlp <- import("BERT", convert = TRUE, delay_load = TRUE)
  assign("nlp", value = nlp, envir = parent.env(local))
  #pyscript <- system.file(package = "golgotha", "python", "BERT.py")
  #source_python(pyscript, envir = nlp, convert = TRUE)
}

known_architectures <- c("BERT", "GPT", "GPT-2", "CTRL", "Transformer-XL", "XLNet", "XLM", "DistilBERT", "RoBERTa", "XLM-RoBERTa",
                         "GPT-2-LMHead")
validate_architecture <- function(architecture){
  if(!architecture %in% known_architectures){
    stop(sprintf("%s not in list of known architectures: %s", paste(architecture, collapse = ", "), paste(known_architectures, collapse = ", ")))
  }
}

#' @import reticulate
NULL
