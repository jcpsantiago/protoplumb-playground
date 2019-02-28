#
# This is a Plumber API using Protocol Buffers. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

#* @apiTitle Plumber+ProtBuf Example API

#* Echo back the input
#* @param req The API request
#* @serializer protoBuf
#* @post /echo
function(req) {
  protoplumb.TestPayload$new(a = req$protobuf$protoplumb.TestPayload$a,
                             b = req$protobuf$protoplumb.TestPayload$b)
}

#* Echo back the input, in a nested message
#* @param req The API request
#* @serializer protoBuf
#* @post /nestedres
function(req) {
  protoplumb.NestedPayload$new(
    nested =
      new(protoplumb.TestPayload,
        a = req$protobuf$protoplumb.TestPayload$a,
        b = req$protobuf$protoplumb.TestPayload$b
      )
  )
}

#* Echo back the input in a flat message
#* @param req The API request
#* @serializer protoBuf
#* @post /flatres
function(req) {
  #browser()
  protoplumb.TestPayload$new(a = req$protobuf$protoplumb.NestedPayload[[1]][[1]]$a,
                             b = req$protobuf$protoplumb.NestedPayload[[1]][[1]]$b)
}
