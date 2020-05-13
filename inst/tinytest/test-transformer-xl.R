model <- transformer(architecture = "Transformer-XL", model_name = "transfo-xl-wt103")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))

## Clean up models folder
unlink_golgotha()
