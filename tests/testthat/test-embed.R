# Transformer_download_model()
test_that("transformer_download_model() with default creates all required model files in the package folder" , {
  transformer_download_model()
  model_path <- system.file(package = "golgotha", "models/bert-base-multilingual-uncased/")
  config_is_present <- file.exists(file.path(model_path,"config.json"))
  model_is_present <- file.exists(file.path(model_path,"pytorch_model.bin"))
  token_map_is_present <- file.exists(file.path(model_path,"special_tokens_map.json"))
  tokenizer_conf_is_present <- file.exists(file.path(model_path,"tokenizer_config.json"))
  vocabulary_is_present <- file.exists(file.path(model_path,"vocab.txt"))
  expect_true(config_is_present)
  expect_true(model_is_present)
  expect_true(token_map_is_present)
  expect_true(tokenizer_conf_is_present)
  expect_true(vocabulary_is_present)
})

test_that("second occurence of the same transformer_download_model() uses cached files" , {
  model_path <- system.file(package = "golgotha", "models/bert-base-multilingual-uncased/")
  cached_model_fileinfo <- file.info(file.path(model_path,"pytorch_model.bin"))
  transformer_download_model()
  updated_model_fileinfo <- file.info(file.path(model_path,"pytorch_model.bin"))
  expect_identical(updated_model_fileinfo$atime, cached_model_fileinfo$atime)
  expect_true((updated_model_fileinfo$atime - cached_model_fileinfo$atime) < 60)
})

MODELS = data.frame(
  architecture=c('GTP','GTP-2','Transformer-XL','XLNet','XLM','DistilBERT',
                 'RoBERTa','XLM-RoBERTa','CamenBERT','T5','FlauBERT'),
  weights = c("openai-gpt","gpt2","transfo-xl-wt103","xlnet-base-cased","xlm-mlm-enfr-1024","distilbert-base-uncased",
              "roberta-base","xlm-roberta-base","camembert-base","t5-small","flaubert-small-cased"),
  nb_tokens = c(19L,21L,11L,20L,19L,18L,
                20L,24L,23L,18L,22L),
  stringsAsFactors = F)
BIG_MODELS = data.frame(
  architecture=c('CTRL'),
  weights = c("ctrl")
)
for (i in 1:nrow(MODELS)) {
  test_that(paste0(MODELS[i,"architecture"], " model architecture can be download"),{
    model_path <- file.path("~/.cache/golgotha")
    transformer_download_model(architecture=MODELS[i,"architecture"], model_name =MODELS[i,"weights"], path=model_path)
    expect_true(file.exists(file.path(model_path,MODELS[i,"weights"],"config.json")))
  })
}

test_that("erroneous model_name raises explicit error in transformer_download_model()" , {
  expect_error(transformer_download_model(model_name = "non-existing-model-name"))
})

test_that("unsupported architecture raises explicit error in transformer_download_model()" , {
  expect_error(transformer_download_model(architecture = "unsupported_architecture"))
})

# Transformer()
test_that("transformer() with default load a BERT archiecture" , {
  model <- transformer(model_name = "bert-base-multilingual-uncased")
  expect_s3_class(model,c("Transformer","__main__.Embedder","python.builtin.object"))
})

# Predict()
for (i in 1:nrow(MODELS)) {
  test_log <- paste0(MODELS[i,"architecture"], " model-architecture can be loaded, and is able to tokenize sentences!")
  x=data.frame(doc_id = MODELS[i,"weights"],  text = test_log, stringsAsFactors = F)
  test_that(test_log,{
    model_path <- file.path("~/.cache/golgotha",MODELS[i,"weights"])
    model <- transformer(architecture = MODELS[i,"architecture"], path=model_path)
    expect_s3_class(model,c("Transformer","__main__.Embedder","python.builtin.object"))
    tokens    <- predict(model, x, type = "tokenise")
    expect_type(tokens,"list")
    expect_type(tokens[[1]],"character")
    expect_equal(length(tokens[[1]]), MODELS[i,"nb_tokens"])
    print(tokens)
  })
}


test_that("predict() with default load a BERT archiecture" , {
  model <- transformer(model_name = "bert-base-multilingual-uncased")
  expect_s3_class(model,c("Transformer","__main__.Embedder","python.builtin.object"))
})

