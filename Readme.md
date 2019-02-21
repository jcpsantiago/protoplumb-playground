## Using Plumber and Protobuf

This is an ongoing effort to add protobuf reading and writing
capabilities to Plumber. As of now it is possible to output
protobuf, and use protobuf as input. Still *unelegantly*.

We can send a message, unserialize it in
plumber, serialize it again, send it back and use protoc to 
unserialize. This works at the moment:

```
echo "a : 123" | \
protoc --encode=protoplumb.TestPayload prototest.proto | \
curl -v --header "Content-Type: application/x-protobuf; messagetype=protoplumb.TestPayload" -X POST --data-binary @- http://localhost:8000/echo | \
protoc --decode=protoplumb.TestPayload prototest.proto

## expected output:
## a: 123
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
* Serializing (`$new`) based on the type of message (get info from the header?)
* Generalize loading `.proto` file
