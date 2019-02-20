#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

#* @apiTitle Plumber Example API

#* Echo back the input
#* @param msg The message to echo
#* @serializer contentType list(type = "Application/x-protobuf")
#* @get /echodefault
function(msg = "DEFAULT") {

  p <- new(protoplumb.TestPayload,
           a = msg)
  
  serialize(p, NULL)
}

#* Echo back the input
#* @param msg The message to echo
#* @serializer contentType list(type = "Application/x-protobuf")
#* @post /echo
function(req) {
  
  req$rook.input$rewind()
  inbound_message <- protoplumb.TestPayload$read(req$rook.input$read())
  
  p <- new(protoplumb.TestPayload,
           a = inbound_message)
  
  serialize(p, NULL)
}
