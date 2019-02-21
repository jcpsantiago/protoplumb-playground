#
# This is a Plumber API using Protocol Buffers. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

#* @apiTitle Plumber+Protobuf Example API

#* Echo back the input
#* @param req The API request
#* @serializer Protobuf
#* @post /echo
function(req) {
  protoplumb.TestPayload$new(a = req$protobuf$protoplumb.TestPayload$a)
}
