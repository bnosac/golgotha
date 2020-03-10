model <- transformer(architecture = "DistilBERT", model_name = "distilbert-base-uncased")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
