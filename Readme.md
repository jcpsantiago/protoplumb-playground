## Using Plumber and Protobuf

This is an example Plumber API using Protocol Buffers aka ProtoBuf,
showcasing functionality from the [protopretzel](https://github.com/ozean12/protopretzel) package.

You can send a ProtoBuf message to the API, and Plumber will unserialize it, serialize it again, send it back as another ProtoBuf message. Twistingly useless :smile: 

This works at the moment:

```
echo "a: 123 b: 456" | \
protoc --encode=protoplumb.TestPayload prototest.proto | \
curl -v --header "Content-Type: application/x-protobuf; messagetype=protoplumb.TestPayload" -X POST --data-binary @- http://localhost:8000/echo | \
protoc --decode=protoplumb.TestPayload prototest.proto

## expected output:
## a: 123
## b: 456
```

the API can also reply with a different type of message (in this case nested):
```
echo "a: 123 b: 456" | \
protoc --encode=protoplumb.TestPayload prototest.proto | \
curl -v --header "Content-Type: application/x-protobuf; messagetype=protoplumb.TestPayload" -X POST --data-binary @- http://localhost:8000/nestedres | \
protoc --decode=protoplumb.NestedPayload prototest.proto

# expected output:
# nested {
#   a: 123
#   b: 456
# }
```

receive a nested message, but reply with something flat:
```
echo "nested: [{a: 123 b: 456}, {a: 1, b: 2}]" | \
protoc --encode=protoplumb.NestedPayload prototest.proto | \
curl -v --header "Content-Type: application/x-protobuf; messagetype=protoplumb.NestedPayload" -X POST --data-binary @- http://localhost:8000/flatres | \
protoc --decode=protoplumb.TestPayload prototest.proto

# expected output:
# nested {
#   a: 123
#   b: 456
# }
```

### The Protobuf filter

The `protobuf_filter` looks for a header of the type
`Content-Type: application/x-protobuf; messagetype=<package>.<messagetype>`, which
is then used to set the correct message type for (un)serializing.

### The Protobuf serializer

Before responding, Plumber serializes the message, and sets the header to
`Content-Type: application/x-protobuf; messagetype=<package>.<messagetype>`.


## TODO
* ~~Add initial filter handling incoming protobuf messages~~
* ~~Add initial serializer for responding with serialized protobuf~~
* ~~Filter that detects which type of message is being received~~
* ~~Serializing (`$new`) based on the type of message (get info from the header?)~~
* ~~Generalize loading `.proto` file~~
* ~~Add endpoints for all examples~~
