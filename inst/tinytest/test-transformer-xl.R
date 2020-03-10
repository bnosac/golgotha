model <- transformer(architecture = "Transformer-XL", model_name = "transfo-xl-wt103")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
embedding <- predict(model, "testing out", type = "embed-token")
expect_true(is.list(embedding))
expect_true(all(sapply(embedding, is.matrix)))

