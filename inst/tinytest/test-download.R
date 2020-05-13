## Non-existing models will fail
expect_error(transformer_download_model(model_name = "non-existing-model-name"))
expect_error(transformer_download_model(architecture = "unsupported_architecture"))

## Clean up models folder
unlink_golgotha()
