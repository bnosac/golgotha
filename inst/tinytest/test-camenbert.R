model <- transformer(architecture = "CamenBERT", model_name = "camembert-base")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
