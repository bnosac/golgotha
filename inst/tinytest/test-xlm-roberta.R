model <- transformer(architecture = "XLM-RoBERTa", model_name = "xlm-roberta-base")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
