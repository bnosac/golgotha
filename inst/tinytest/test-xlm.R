model <- transformer(architecture = "XLM", model_name = "xlm-mlm-enfr-1024")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))

## Clean up models folder
unlink_golgotha()
