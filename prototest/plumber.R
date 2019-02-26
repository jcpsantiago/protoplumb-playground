library(plumber)
library(protopretzel)

# Needs to be added before API creation
addProtobufSerializer()

api <- plumber$new(here::here("prototest/api.R"))

addProtobufFilter(api, descriptor_path = here::here("prototest.proto"))

api$run(host = "0.0.0.0", port = 8000)
