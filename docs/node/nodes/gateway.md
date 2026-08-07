---
sidebar_label: Gateway
hide_table_of_contents: true
---

# Gateway

The `gateway` node-type enables VILLASnode to translate between Application Programmable Interfaces (API) types. 
Currently, the transformation of [HTTP](https://en.wikipedia.org/wiki/HTTP) and [gRPC](https://grpc.io/) is supported. 

## Prerequisites

This node-type requires [gRPC](https://grpc.io/) and [reflection.proto](https://github.com/grpc/grpc/blob/master/src/proto/grpc/reflection/v1alpha/reflection.proto) for gRPC server [reflection](https://grpc.io/docs/guides/reflection/).
The script `packaging/deps.sh` can be used to automatically download reflection.proto and generate protobuf code.
Please refer to the [installation document](../installation.md).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/gateway.cpp

### Limitations

- The `gateway` node-type only supportes unary RPC.

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/api" />

## Example

``` url="external/node/etc/examples/nodes/gateway.conf" title="node/etc/examples/nodes/api.conf"
http = {
    port = 8080
}

nodes = {
    gateway_node = {
        type = "gateway"

        format = "protobuf"
        #  API type
        gateway_type = "gRPC"
        # Address of remote server
        address = "localhost:50051"
    }
}
```

## Usage

The usage of this node is similar to [`api`](api.md) node-type.
The following [`curl`](https://curl.se/) commands are examples for calling gRPC methods via the HTTP API.
The input for a gRPC call can be either the body of HTTP request or input data from another node (via a [path](../config/paths.md)).
If the http request body is empty, the input from other node will be used.

Since this node-type does not implement the gRPC server, it needs to be added manually. A description is available [1].

Note on HTTP methods
 - GET should be used only when the input of gRPC method can be empty or ignored.
 - PUT should be used when the output of gRPC method is in VILLASnode format and the user want to put the data to the path.
 - POST should be used when the output of gRPC method is not in VILLASnode format or the user not want output data to the path.

### General Request

The URL for sending a request to the gateway node-type is as following:
```
http://<address>:<port>/api/v2/gateway/<node name or UUID>/<gRPC package>/<gRPC service>/<gRPC method>
```

The following `server.proto` file will be used as an example which imports the already existing [`villas.proto`](https://github.com/VILLASframework/node/blob/master/lib/formats/villas.proto) data format. 
```
syntax = "proto3";

import "villas.proto";

package ex_server;

service ex_service {
    rpc GetData (villas.node.Message) returns (villas.node.Message) {};
    rpc SetData (villas.node.Message) returns (msg) {};
    rpc GetDataRef (Reference) returns (villas.node.Message) {};
}

message Reference {
    repeated int32 ref = 1;
}

message msg {
    string status = 1;
}

```

### Call `GetData` method on gRPC server
The `GetData` method writes the data from gRPC server to the VILLASnode path. 
It uses the PUT method. 

```shell
curl http://localhost:8080/api/v2/gateway/gateway_node/ex_server/ex_service/GetData -XPUT
```

### Call `SetData` method on gRPC server
The `SetData` method writes the data from the VILLASnode path to the gRPC server. 
No data is given in the request body. 
It uses the POST method. 

```shell
curl http://localhost:8080/api/v2/gateway/gateway_node/ex_server/ex_service/SetData -XPOST
```

### Call `GetDataRef` method on gRPC server
The `GetDataRef` method requests data of the gRPC based on input references, e.g., referring to nodes in the simulation. 
The body provides a protobuf payload based on the example `.proto` file. 
VILLASnode send the request to the gRPC server.

```shell
curl http://localhost:8080/api/v2/gateway/gateway_node/ex_server/ex_service/GetDataRef -d '{"ref":[0,1,2,3,4]}'
```

# Reference
[1] Jitpanu Maneeratpongsuk, "Enhancing Interoperability and Automation in Co-Simulations: An API Gateway Approach for VILLASnode," [Online]. Available: https://www.acs.eonerc.rwth-aachen.de/global/show_document.asp?id=aaaaaaaadidaesd