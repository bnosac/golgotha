#' @title Download a BERT-like Transformers model
#' @description Download a BERT-like Transformers model
#' @param model_name character string with the name of the model. E.g. 'bert-base-uncased', 'bert-base-multilingual-uncased', 'bert-base-multilingual-cased', 'bert-base-dutch-cased'. Defaults to 'bert-base-multilingual-uncased'.
#' @param path path to a directory on disk where the model will be downloaded to inside a subfolder \code{model_name}
#' @export
#' @return invisibly, the directory where the model is saved to
#' @examples
#' \dontrun{
#' bert_download_model("bert-base-multilingual-uncased")
#' bert_download_model("bert-base-dutch-cased")
#'
#' path <- file.path(getwd(), "inst", "models")
#' bert_download_model("bert-base-multilingual-uncased", path = path)
#' bert_download_model("bert-base-dutch-cased", path = path)
#' }
bert_download_model <- function(model_name = "bert-base-multilingual-uncased",
                                path = system.file(package = "golgotha", "models")){
  path <- file.path(path, model_name)
  if(!dir.exists(path)){
    dir.create(path, recursive = TRUE)
  }
  cat(sprintf("Downloading model to %s", path))
  x <- nlp$download(model_name = model_name, path = path.expand(path))
  invisible(x)
}


#' @title Load a BERT-like Transformer model
#' @description Load a BERT-like Transformer model stored on disk
#' @param model_name character string with the name of the model. E.g. 'bert-base-uncased', 'bert-base-multilingual-uncased', 'bert-base-multilingual-cased', 'bert-base-dutch-cased'. Defaults to 'bert-base-multilingual-uncased'.
#' @param path path to a directory on disk where the model is stored
#' @export
#' @return the directory where the model is saved to
#' @examples
#' \dontrun{
#' bert_download_model("bert-base-multilingual-uncased")
#' model <- BERT("bert-base-multilingual-uncased")
#'
#' x <- data.frame(doc_id = c("doc_1", "doc_2"),
#'                 text = c("provide some words to embed", "another sentence of text"),
#'                 stringsAsFactors = FALSE)
#' predict(model, x, type = "tokenise")
#' embedding <- predict(model, x, type = "embed-sentence")
#' dim(embedding)
#' embedding <- predict(model, x, type = "embed-token")
#' str(embedding)
#' }
#'
#' \dontrun{
#' model_dir <- file.path(getwd(), "inst", "models")
#' bert_download_model("bert-base-multilingual-uncased", path = model_dir)
#' path  <- file.path(getwd(), "inst", "models", "bert-base-multilingual-uncased")
#' model <- BERT(path = path)
#' }
BERT <- function(model_name, path = system.file(package = "golgotha", "models")){
  if(missing(path)){
    path <- file.path(path, model_name)
    if(!dir.exists(path)){
      path <- bert_download_model(model_name)
    }
  }
  path = path.expand(path)
  x <- nlp$Embedder(path = path)
  class(x) <- c("BERT", class(x))
  x
}

#' @title Download a Transformers model
#' @description Download a Transformers model
#' @param model_name character string with the name of the model. E.g. 'bert-base-uncased', 'bert-base-multilingual-uncased', 'bert-base-multilingual-cased', 'bert-base-dutch-cased'. Defaults to 'bert-base-multilingual-uncased'.
#' @param architecture character string with the model architecture family name. E.g. 'BERT', 'DistilBERT', 'Roberta',.... Defaults to 'BERT'.
#' @param path path to a directory on disk where the model will be downloaded to inside a subfolder \code{model_name}
#' @export
#' @return invisibly, the directory where the model is saved to
#' @examples
#' \dontrun{
#' transformer_download_model("bert-base-multilingual-uncased")
#' transformer_download_model(model_name = "distilbert-base-multilingual-uncased",
#'                            architecture = "DistilBERT")
#'
#' path <- file.path(getwd(), "inst", "models")
#' transformer_download_model("bert-base-multilingual-uncased", path = path)
#' transformer_download_model(model_name = "distilbert-base-multilingual-uncased",
#'                            architecture ="DistilBERT", path = path)
#' }
transformer_download_model <- function(model_name = "bert-base-multilingual-uncased",
                                       architecture="BERT", path = system.file(package = "golgotha", "models")){
  path <- file.path(path, model_name)
  if(!dir.exists(path)){
    dir.create(path, recursive = TRUE)
  }
  assertthat::assert_that(architecture %in% c("BERT","GTP","GTP-2","CTRL","Transformer-XL","XLNet","XLM","DistilBERT","RoBERTa","XLM-RoBERTa"),
                          msg="Specified model architecture is not available, \nplease choose architecture  within 'BERT','GTP','GTP-2','CTRL','Transformer-XL','XLNet','XLM','DistilBERT','RoBERTa' or 'XLM-RoBERTa'")
  cat(sprintf("Downloading model to %s", path))
  x <- nlp$download(model_name = model_name, architecture = architecture, path = path.expand(path))
  invisible(x)
}


#' @title Load a Transformer model
#' @description Load a Transformer model stored on disk
#' @param model_name character string with the name of the model. E.g. 'bert-base-uncased', 'bert-base-multilingual-uncased', 'distilbert-base-cased', 'bert-base-dutch-cased'. Defaults to 'bert-base-multilingual-uncased'.
#' @param architecture character string with the model architecture family name. E.g. 'BERT', 'DistilBERT', 'Roberta',.... Defaults to 'BERT'.
#' @param path path to a directory on disk where the model is stored
#' @export
#' @return the directory where the model is saved to
#' @examples
#' \dontrun{
#' transformer_download_model("bert-base-multilingual-uncased")
#' model <- transformer("bert-base-multilingual-uncased")
#'
#' x <- data.frame(doc_id = c("doc_1", "doc_2"),
#'                 text = c("provide some words to embed", "another sentence of text"),
#'                 stringsAsFactors = FALSE)
#' predict(model, x, type = "tokenise")
#' embedding <- predict(model, x, type = "embed-sentence")
#' dim(embedding)
#' embedding <- predict(model, x, type = "embed-token")
#' str(embedding)
#' }
#'
#' \dontrun{
#' model_dir <- file.path(getwd(), "inst", "models")
#' transformer_download_model("distilbert-base-multilingual-uncased",
#'                            architecture = "DistilBERT", path = model_dir)
#' path  <- file.path(getwd(), "inst", "models", "distilbert-base-multilingual-uncased")
#' model <- transformer(path = path, architecture = "DistilBERT")
#' }
transformer <- function(model_name, path = system.file(package = "golgotha", "models"), architecture = "BERT"){
  if(missing(path)){
    path <- file.path(path, model_name)
    if(!dir.exists(path)){
      path <- transformer_download_model(model_name, architecture = architecture)
    }
  }
  assertthat::assert_that(architecture %in% c("BERT","GTP","GTP-2","CTRL","Transformer-XL","XLNet","XLM","DistilBERT","RoBERTa","XLM-RoBERTa"),
                          msg="Specified model architecture is not available, \nplease choose architecture  within 'BERT','GTP','GTP-2','CTRL','Transformer-XL','XLNet','XLM','DistilBERT','RoBERTa' or 'XLM-RoBERTa'")
  path = path.expand(path)
  x <- nlp$Embedder(path = path, architecture = architecture)
  class(x) <- c("Transformer", class(x))
  x
}

#' @title Predict alongside a BERT-like Transformer model
#' @description Extract features from the BERT model namely get
#' \itemize{
#' \item the embedding of a sentence
#' \item the embedding of the tokens of the sentence
#' \item the tokens of a sentence
#' }
#' @param object an object of class BERT as returned by \code{\link{BERT}}
#' @param newdata a data.frame with columns doc_id and text indicating the text to embed
#' @param type a character string, either 'embed-sentence', 'embed-token', 'tokenise' to get respectively sentence-level embeddings, token-level embeddings or the wordpiece tokens
#' @param trace logical indicating to show a trace of the progress. Defaults to showing every 10 annotated embeddings
#' @param ... other arguments passed on to the methods
#' @export
#' @return depending on the argument \code{type} the function returns:
#' \itemize{
#' \item embed-sentence: A matrix with the embedding of the text, where the doc_id's are in the rownames
#' \item embed-token: A list of matrices with token-level embeddings, one for each doc_id. The names of the list are identified by the doc_id. Note that depending on the model you will have CLS / SEP tokens at the start/back and the number of rows of the matrix is also limited by the model
#' \item tokenise: A list of subword (wordpiece) tokens. The names of the list are identified by the doc_id.
#' }
#' @examples
#' \dontrun{
#' bert_download_model("bert-base-multilingual-uncased")
#' model <- BERT("bert-base-multilingual-uncased")
#'
#' x <- data.frame(doc_id = c("doc_1", "doc_2"),
#'                 text = c("provide some words to embed", "another sentence of text"),
#'                 stringsAsFactors = FALSE)
#' predict(model, x, type = "tokenise")
#' embedding <- predict(model, x, type = "embed-sentence")
#' dim(embedding)
#' embedding <- predict(model, x, type = "embed-token")
#' str(embedding)
#' }
predict.BERT <- function(object, newdata, type = c("embed-sentence", "embed-token", "tokenise"), trace = 10, ...){
  if(is.character(newdata)){
    if(is.null(names(newdata))){
      newdata <- data.frame(doc_id = seq_along(newdata), text = newdata, stringsAsFactors = FALSE)
    }else{
      newdata <- data.frame(doc_id = names(newdata), text = as.character(newdata), stringsAsFactors = FALSE)
    }
  }
  stopifnot(is.data.frame(newdata))
  stopifnot(all(c("doc_id", "text") %in% colnames(newdata)))
  stopifnot(is.character(newdata$text))
  if(type == "tokenise"){
    results <- lapply(newdata$text, FUN=object$tokenize)
    names(results) <- newdata$doc_id
  }else{
    results <- list()
    for(row in seq_len(nrow(newdata))){
      doc <- newdata$doc_id[row]
      if(trace == TRUE || (row %% trace) == 1){
        cat(sprintf("%s: %s/%s", Sys.time(), row, nrow(newdata)), sep = "\n")
      }
      if(type == "embed-token"){
        emb <- object$embed_tokens(text = newdata$text[row], ...)
        emb <- emb[[1]]
        emb <- do.call(rbind, emb)
      }else if(type == "embed-sentence"){
        emb <- object$embed_sentence(text = newdata$text[row], ...)
      }
      results[[doc]] <- emb
    }
    if(type == "embed-sentence"){
      results <- do.call(rbind, results)
    }
  }
  results
}

#' @title Predict alongside a Transformer model
#' @description Extract features from the Transformer model namely get
#' \itemize{
#' \item the embedding of a sentence
#' \item the embedding of the tokens of the sentence
#' \item the tokens of a sentence
#' }
#' @param object an object of class Transformer as returned by \code{\link{transformer}}
#' @param newdata a data.frame with columns doc_id and text indicating the text to embed
#' @param type a character string, either 'embed-sentence', 'embed-token', 'tokenise' to get respectively sentence-level embeddings, token-level embeddings or the wordpiece tokens
#' @param trace logical indicating to show a trace of the progress. Defaults to showing every 10 annotated embeddings
#' @param ... other arguments passed on to the methods
#' @export
#' @return depending on the argument \code{type} the function returns:
#' \itemize{
#' \item embed-sentence: A matrix with the embedding of the text, where the doc_id's are in the rownames
#' \item embed-token: A list of matrices with token-level embeddings, one for each doc_id. The names of the list are identified by the doc_id. Note that depending on the model you will have CLS / SEP tokens at the start/back and the number of rows of the matrix is also limited by the model
#' \item tokenise: A list of subword (wordpiece) tokens. The names of the list are identified by the doc_id.
#' }
#' @examples
#' \dontrun{
#' transformer_download_model("bert-base-multilingual-uncased")
#' model <- transformer("bert-base-multilingual-uncased")
#'
#' x <- data.frame(doc_id = c("doc_1", "doc_2"),
#'                 text = c("provide some words to embed", "another sentence of text"),
#'                 stringsAsFactors = FALSE)
#' predict(model, x, type = "tokenise")
#' embedding <- predict(model, x, type = "embed-sentence")
#' dim(embedding)
#' embedding <- predict(model, x, type = "embed-token")
#' str(embedding)
#' }

predict.Transformer <- function(object, newdata, type = c("embed-sentence", "embed-token", "tokenise"), trace = 10, ...){
  if(is.character(newdata)){
    if(is.null(names(newdata))){
      newdata <- data.frame(doc_id = seq_along(newdata), text = newdata, stringsAsFactors = FALSE)
    }else{
      newdata <- data.frame(doc_id = names(newdata), text = as.character(newdata), stringsAsFactors = FALSE)
    }
  }
  stopifnot(is.data.frame(newdata))
  stopifnot(all(c("doc_id", "text") %in% colnames(newdata)))
  stopifnot(is.character(newdata$text))
  if(type == "tokenise"){
    results <- lapply(newdata$text, FUN=object$tokenize)
    names(results) <- newdata$doc_id
  }else{
    results <- list()
    for(row in seq_len(nrow(newdata))){
      doc <- newdata$doc_id[row]
      if(trace == TRUE || (row %% trace) == 1){
        cat(sprintf("%s: %s/%s", Sys.time(), row, nrow(newdata)), sep = "\n")
      }
      if(type == "embed-token"){
        emb <- object$embed_tokens(text = newdata$text[row], ...)
        emb <- emb[[1]]
        emb <- do.call(rbind, emb)
      }else if(type == "embed-sentence"){
        emb <- object$embed_sentence(text = newdata$text[row], ...)
      }
      results[[doc]] <- emb
    }
    if(type == "embed-sentence"){
      results <- do.call(rbind, results)
    }
  }
  results
}
