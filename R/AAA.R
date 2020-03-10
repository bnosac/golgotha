

nlp <- new.env()

.onLoad <- function(libname, pkgname) {
  packageStartupMessage("- Connecting/Setting up Python using reticulate")
  reticulate::configure_environment(pkgname)
  packageStartupMessage("- Loading golgotha Transformer code")
  pyscript <- system.file(package = "golgotha", "python", "Transformers.py")
  source_python(pyscript, envir = nlp, convert = TRUE)
}

known_architectures <- c("BERT", "GPT", "GPT-2", "CTRL", "XLNet", "XLM", "DistilBERT", "RoBERTa", "XLM-RoBERTa",
                         "GPT-2-LMHead", "CamenBERT", "FlauBERT")
validate_architecture <- function(architecture){
  if(!architecture %in% known_architectures){
    stop(sprintf("%s not in list of known architectures: %s", paste(architecture, collapse = ", "), paste(known_architectures, collapse = ", ")))
  }
}

#' @import reticulate
NULL
