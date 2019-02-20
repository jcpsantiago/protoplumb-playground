## Readme

This is an ongoing effort to add protobuf reading and writing
capabilities to Plumber. As of now it is possible to output
protobuf, but not use input.

This will correctly encode a string in plumber and respond
with a serialized protobuf message, that we can unserialize:
```
curl -X GET http://localhost:8000/echodefault | protoc --decode=protoplumb.TestPayload prototest.proto

## expected output:
## a: "DEFAULT"
```

Now we should also be able to send a string, unserialize it in
plumber, serialize it again, send it back and use protoc to 
unserialize. This doesn't work yet:
```
echo "a : 'abc'"  | protoc --encode=protoplumb.TestPayload prototest.proto | curl -X POST -d @- http://localhost:8000/echo | protoc --decode=protoplumb.TestPayload prototest.proto

## expected output:
## a: "abc"
```