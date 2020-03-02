# golgotha - Contextualised Embeddings and Language Modelling using BERT and Friends using R

- This R package wraps the transformers module using reticulate
- The objective of the package is to get easily sentence embeddings using a BERT-like model in R
  For using in downstream modelling (e.g. Support Vector Machines / Sentiment Labelling / Classification / Regression / POS tagging / Lemmatisation / Text Similarities)
- Golgotha: Hope for lonely AI pelgrims on their way to losing CPU power: http://costes.org/cdbm20.mp3

![](vignettes/golgotha-logo.png)

## Installation

- For installing the development version of this package: 
    - Execute in R: `devtools::install_github("bnosac/golgotha", INSTALL_opts = "--no-multiarch")`
    - Look to the documentation of the functions: `help(package = "golgotha")`

## Example with BERT model architecture

- Download a model (e.g. bert multilingual lowercased) 

```{r}
library(golgotha)
transformer_download_model("bert-base-multilingual-uncased")
```

- Load the model and get the embedding of sentences / subword tokens or just tokenise

```{r}
model <- transformer("bert-base-multilingual-uncased")
x <- data.frame(doc_id = c("doc_1", "doc_2"),
                text = c("give me back my money or i'll call the police.",
                         "talk to the hand because the face don't want to hear it any more."),
                stringsAsFactors = FALSE)
embedding_sent <- predict(model, x, type = "embed-sentence")
embedding_tok <- predict(model, x, type = "embed-token")
tokens    <- predict(model, x, type = "tokenise")
```

- Same example but now on Dutch / French

```{r}
text <- c("vlieg met me mee naar de horizon want ik hou alleen van jou",
          "l'amour n'est qu'un enfant de pute, il agite le bonheur mais il laisse le malheur",
          "http://costes.org/cdso01.mp3", 
          "http://costes.org/mp3.htm")
text <- setNames(text, c("doc_nl", "doc_fr", "le petit boudin", "thebible"))
embedding_sent <- predict(model, text, type = "embed-sentence")
embedding_tok <- predict(model, text, type = "embed-token")
tokens    <- predict(model, text, type = "tokenise")
```
## Example with DistilBERT model architecture

For any model architecture but `BERT`, you have to provide argument `architecture` within the [10 supported model architectures](https://github.com/huggingface/transformers#model-architectures)

- Download a model (e.g. distilbert multilingual lowercased) and store it in a specific folder

```{r}
library(golgotha)
transformer_download_model("distilbert-base-multilingual-uncased", architecture="DistilBERT", path="~/.cache/transformer/")
```

- Recall the downloaded model from its path and get the embedding of sentences / subword tokens or just tokenise

```{r}
model <- transformer(path="~/.cache/transformer/distilbert-base-multilingual-uncased", architecture="DistilBERT")
x <- data.frame(doc_id = c("doc_1", "doc_2"),
                text = c("give me back my money or i'll call the police.",
                         "talk to the hand because the face don't want to hear it any more."),
                stringsAsFactors = FALSE)
embedding_sent <- predict(model, x, type = "embed-sentence")
embedding_tok <- predict(model, x, type = "embed-token")
tokens    <- predict(model, x, type = "tokenise")
```

## Some other models available
The list is not exhaustive. Refer to [transformer documentation](https://github.com/huggingface/transformers#quick-tour) for latest model list

```{r}
model <- transformer("bert-base-multilingual-uncased")
model <- transformer("bert-base-multilingual-cased")
model <- transformer("bert-base-dutch-cased")
model <- transformer("bert-base-uncased")
model <- transformer("bert-base-cased")
model <- transformer("bert-base-chinese")
model <- transformer("distilbert-base-uncased", architecture = "DistilBERT")
model <- transformer("distilbert-base-uncased-distilled-squad", architecture = "DistilBERT")
model <- transformer("distilbert-base-cased", architecture = "DistilBERT")
model <- transformer("distilbert-base-cased-distilled-squad", architecture = "DistilBERT")
model <- transformer("distilbert-base-german-cased", architecture = "DistilBERT")
model <- transformer("distilgpt2", architecture = "DistilBERT")
model <- transformer("distilroberta-base", architecture = "DistilBERT")
model <- transformer("distilbert-base-multilingual-cased", architecture = "DistilBERT")
```
