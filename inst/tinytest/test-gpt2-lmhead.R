model <- transformer(architecture = "GPT-2-LMHead", model_name = "distilgpt2")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
generate <- predict(model, c("R is a programming language for"),
        type = "generate", max_length = 15L)
expect_true(is.list(generate))
expect_true(all(sapply(generate, is.character)))
