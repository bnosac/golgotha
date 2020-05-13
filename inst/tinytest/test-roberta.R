model <- transformer(architecture = "RoBERTa", model_name = "roberta-base")
expect_true(inherits(model, "Transformer"))
expect_true(inherits(predict(model, "testing out", type = "embed-sentence", trace = FALSE), "matrix"))

## Clean up models folder
unlink_golgotha()
