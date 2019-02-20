library(plumber)

library(RProtoBuf)

readProtoFiles(here::here("prototest.proto"))

api <- plumber$new(here::here("prototest/api.R"))

api$filter("myFilter", function(req){
  req$pure <- req$rook.input$read()
  forward()
})

api$run(host = "0.0.0.0", port = 8000)
