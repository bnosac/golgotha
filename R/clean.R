#' @title Delete all subfolders of the models directory
#' @description Delete all subfolders of the models directory
#' @param x the path to the folder of the default models directory where the package stores it models
#' @export
#' @return a character vector of directories which were removed
#' @examples
#' unlink_golgotha()
unlink_golgotha <- function(x = system.file(package = "golgotha", "models")){
  d <- setdiff(list.dirs(path = x), x)
  unlink(d, recursive = TRUE)
  invisible(d)
}
