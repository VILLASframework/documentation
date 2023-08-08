# Python {#node-client-python}

**Source code:** <https://github.com/VILLASframework/node/tree/master/clients/python>

The page documents a simple Python client application which can exchange simulation data VILLASnode via BSD [sockets](https://docs.python.org/3/library/socket.html) and [Google's Protocol Buffers](https://developers.google.com/protocol-buffers/).
The page documents a simple Python client application which can exchange simulation data VILLASnode via BSD [sockets](https://docs.python.org/3/library/socket.html) and [Google's Protocol Buffers](https://developers.google.com/protocol-buffers/).

The code of this client implementation is available in the VILLASnode Git repository: [VILLASnode/clients/python/villas.py](https://github.com/VILLASframework/node/blob/master/clients/python/client.py)
Please notice that there is also an extra branch called python-client-lab to store python development related code. 

## Compile protobuf 
The python client requires the library ``villas_pb2``. 
This is typical of protobuf. 
The source code is stored in git: [VILLASnode/lib/formats/villas.proto](https://github.com/VILLASframework/node/blob/master/lib/formats/villas.proto)
This file has to be compiled, e.g., by the command below. 
```shell
protoc -I=$SRC_DIR --python_out=$DST_DIR $SRC_DIR/addressbook.proto
protoc -I=./lib/formats --python_out=./clients/python ./lib/formats/villas.proto
```
Please refer to [python protobuf documentation](https://protobuf.dev/getting-started/pythontutorial/) for more information.

## Client Description
The python client builds on the socket library of python. 
Since UDP is used, the socket has to bind to a specific port. 
In this case on localhost and port 12001. 
After the socket is set up, the python client is ready to receive data. 
If data is received, the protobuf function ``ParseFromString`` is used so that the message can be printed in JSON format. 
Then the same message is send back using ``SerializeToString``.

You can change the python client configration, e.g., to send constants back instead of the same message. 
Example code is available in the [python-client-lab branch](https://github.com/VILLASframework/node/tree/python-client-lab/clients/python).