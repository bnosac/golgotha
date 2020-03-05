## Loading the default model
transformer_download_model()
model_path <- system.file(package = "golgotha", "models", "bert-base-multilingual-uncased")
expect_true(file.exists(file.path(model_path, "config.json")))
expect_true(file.exists(file.path(model_path, "pytorch_model.bin")))
expect_true(file.exists(file.path(model_path, "special_tokens_map.json")))
expect_true(file.exists(file.path(model_path, "tokenizer_config.json")))
expect_true(file.exists(file.path(model_path, "vocab.txt")))

## Loading the default model
model <- transformer("bert-base-multilingual-uncased")
expect_true(inherits(model, "Transformer"))
model <- BERT("bert-base-multilingual-uncased")
expect_true(inherits(model, "BERT"))


## Test scoring
x <- data.frame(doc_id = c("doc_1", "doc_2"),
                text = c("give me back my money or i'll call the police.",
                         "talk to the hand because the face don't want to hear it any more."),
                stringsAsFactors = FALSE)
embedding <- predict(model, x, type = "embed-sentence", trace = FALSE)
expect_true(is.matrix(embedding))
expect_true(nrow(embedding) == 2)
embedding <- predict(model, x, type = "embed-token")
expect_true(is.list(embedding))
expect_true(all(sapply(embedding, is.matrix)))
tokens    <- predict(model, x, type = "tokenise")
expect_true(is.list(tokens))
expect_true(all(sapply(tokens, is.character)))
