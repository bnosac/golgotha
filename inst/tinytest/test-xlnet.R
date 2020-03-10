model <- transformer(architecture = "XLNet", model_name = "xlnet-base-cased")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
