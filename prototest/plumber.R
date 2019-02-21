library(plumber)
library(RProtoBuf)

readProtoFiles(here::here("prototest.proto"))

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

api$filter("protobuf_filter", function(req) {
  protobuf_header <- setNames(
    as.list(stringr::str_match(
      req$HEADERS["content-type"],
      stringr::regex("application/x-protobuf;\\s*messagetype=([\\w\\.]+)")
    )),
    c("content-type", "message-type")
  )
  
  protobuf_message_type <- protobuf_header[["message-type"]]

  if (!is.na(protobuf_message_type)) {
    
    # rook.input contains the incoming request as a strem, so we need to rewind
    # it first to get the value
    req$rook.input$rewind()
  
    req$protobuf <- setNames(
      list(
        RProtoBuf::read(
          get(protobuf_message_type), 
          req$rook.input$read()
          )
        ), 
      protobuf_message_type
    )
  }

  forward()
})

api$run(host = "0.0.0.0", port = 8000)
