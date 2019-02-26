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
  browser()
  protoplumb.TestPayload$new(a = req$protobuf$protoplumb.TestPayload$a)
}

#* Echo back the input
#* @param req The API request
#* @serializer protoBuf
#* @post /nestedres
function(req) {
  #browser()
  protoplumb.NestedPayload$new(test = 
                                 list(new(protoplumb.TestPayload,
                                          a = req$protobuf$protoplumb.TestPayload$a),
                                      new(protoplumb.TestPayload,
                                          a = req$protobuf$protoplumb.TestPayload$a)
                                 )
  )
}
