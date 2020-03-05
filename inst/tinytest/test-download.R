## Non-existing models will fail
expect_error(transformer_download_model(model_name = "non-existing-model-name"))
expect_error(transformer_download_model(architecture = "unsupported_architecture"))

## Checking other models
MODELS <- data.frame(
  architecture = c('GPT','GPT-2','Transformer-XL','XLNet','XLM','DistilBERT','RoBERTa','XLM-RoBERTa'),
  weights = c("openai-gpt","gpt2","transfo-xl-wt103","xlnet-base-cased","xlm-mlm-enfr-1024","distilbert-base-cased","roberta-base","xlm-roberta-base"),
  stringsAsFactors = FALSE)

for (i in 1:nrow(MODELS)) {
  model <- transformer(architecture = MODELS$architecture[i], model_name = MODELS$weights[i])
  expect_true(inherits(model, "Transformer"))
  expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
}
