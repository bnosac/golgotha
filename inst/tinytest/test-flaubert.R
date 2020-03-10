model <- transformer(architecture = "FlauBERT", model_name = "flaubert-small-cased")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
