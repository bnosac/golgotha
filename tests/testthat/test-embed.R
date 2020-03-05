# Transformer_download_model()
test_that("transformer_download_model() with default create all required model files in the package folder" , {
  transformer_download_model()
  model_path <- system.file(package = "golgotha", "models/bert-base-multilingual-uncased/")
  expect_true(file.exists(paste0(model_path,"config.json")))
  expect_true(file.exists(paste0(model_path,"pytorch_model.bin")))
  expect_true(file.exists(paste0(model_path,"special_tokens_map.json")))
  expect_true(file.exists(paste0(model_path,"tokenizer_config.json")))
  expect_true(file.exists(paste0(model_path,"vocab.txt")))
})

test_that("second occurence of the same transformer_download_model() uses cached files" , {
  model_path <- system.file(package = "golgotha", "models/bert-base-multilingual-uncased/")
  cached_model_fileinfo <- file.info(paste0(model_path,"pytorch_model.bin"))
  transformer_download_model()
  updated_model_fileinfo <- file.info(paste0(model_path,"pytorch_model.bin"))
  expect_identical(updated_model_fileinfo$atime, cached_model_fileinfo$atime)
  expect_true((updated_model_fileinfo$atime - cached_model_fileinfo$atime) < 60)
})

MODELS = data.frame(
  architecture=c('GTP','GTP-2','Transformer-XL','XLNet','XLM','DistilBERT','RoBERTa','XLM-RoBERTa'),
  weights = c("openai-gpt","gpt2","transfo-xl-wt103","xlnet-base-cased","xlm-mlm-enfr-1024","distilbert-base-cased","roberta-base","xlm-roberta-base"),
  stringsAsFactors = F)
BIG_MODELS = data.frame(
  architecture=c('CTRL'),
  weights = c("ctrl")
)
for (i in 1:nrow(MODELS)) {
  test_that(paste0(MODELS[i,"architecture"], " model architecture can be download"),{
    model_path <- file.path("~/.cache/RBERT")
    transformer_download_model(architecture=MODELS[i,"architecture"], model_name =MODELS[i,"weights"], path=model_path)
    expect_true(file.exists(paste0(model_path,"/",MODELS[i,"weights"],"/config.json")))
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

for (i in 1:nrow(MODELS)) {
  test_log <- paste0(MODELS[i,"architecture"], " model architecture can be loaded and is able to tokenize sentences")
  x=data.frame(doc_id = MODELS[i,"weights"],  text = test_log, stringsAsFactors = F)
  test_that(test_log,{
    model_path <- paste0(file.path("~/.cache/RBERT/"),MODELS[i,"weights"])
    model <- transformer(architecture = MODELS[i,"architecture"], path=model_path)
    expect_s3_class(model,c("Transformer","__main__.Embedder","python.builtin.object"))
    tokens    <- predict(model, x, type = "tokenise")
    expect_type(tokens,"list")
    print(tokens)
  })
}


# Predict()
test_that("predict() with default load a BERT archiecture" , {
  model <- transformer(model_name = "bert-base-multilingual-uncased")
  expect_s3_class(model,c("Transformer","__main__.Embedder","python.builtin.object"))
})

