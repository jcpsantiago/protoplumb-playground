library(plumber)
library(protopretzel)

serializer_protobuf <- function() {
  function(val, req, res, errorHandler) {
    tryCatch({
      res$setHeader("Content-Type", 
                    paste0("application/x-protobuf; messagetype=", val@type))
      res$body <- RProtoBuf::serialize(val, NULL)
      return(res$toResponse())
    }, error = function(e) {
      errorHandler(req, res, e)
    })
  }
}

addSerializer("Protobuf", serializer_protobuf)

api <- plumber$new(here::here("prototest/api.R"))

addProtobufFilter(api, descriptor_path = here::here("prototest.proto"))

api$run(host = "0.0.0.0", port = 8000)
