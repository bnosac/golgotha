model <- transformer(architecture = "GPT", model_name = "openai-gpt")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))
