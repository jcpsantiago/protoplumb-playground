library(plumber)

library(RProtoBuf)

readProtoFiles(here::here("prototest.proto"))

serializer_protobuf <- function(){
  function(val, req, res, errorHandler){
    tryCatch({
      res$setHeader("Content-Type", "application/x-protobuf")
      res$body <- RProtoBuf::serialize(val, NULL)
      return(res$toResponse())
    }, error = function(e){
      errorHandler(req, res, e)
    })
  }
}

addSerializer("Protobuf", serializer_protobuf)

api <- plumber$new(here::here("prototest/api.R"))

api$filter("protobufFilter", function(req){
  req$rook.input$rewind()
  req$binaryBody <- protoplumb.TestPayload$read(req$rook.input$read())
  forward()
})

api$run(host = "0.0.0.0", port = 8000)
