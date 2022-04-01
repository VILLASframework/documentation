---
hide_table_of_contents: true
---

# nanomsg

The `nanomsg` node-type uses [libzmq] to exchange messages via the [ZMTP](https://rfc.nanomsg.org/spec:23/ZMTP/) protocol. It is similiar to the [`zeromq` node-type](zeromq.md).

> nanomsg is a socket library that provides several common communication patterns. It aims to make the networking layer fast, scalable, and easy to use. Implemented in C, it works on a wide range of operating systems with no further dependencies.

The `nanomsg` node-type only implements the [publish-subscribe protocol](http://nanomsg.org/v1.0.0/nn_pubsub.7.html) provided by nanomsg.

## Prerequisites

This node-type requires [libnanomsg](http://nanomsg.org/) (>= 1.0.0).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/nanomsg.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/nanomsg" />

### Endpoints

The `nanomsg` supports several different transport mechanisms which are listed in the following table:

| Name	| URI example		| Documentation									|
| :--		| :--					| :--												|
| In-process transport | `inproc://test` 	| [nn_inproc(7)](http://nanomsg.org/v1.0.0/nn_inproc.7.html) |
| Inter-process transport | `ipc:///tmp/test.ipc` | [nn_ipc(7)](http://nanomsg.org/v1.0.0/nn_ipc.7.html) |
| TCP transport | `tcp://1.1.1.1:456`	| [nn_tcp(7)](http://nanomsg.org/v1.0.0/nn_tcp.7.html) |
| WebSocket transport | `ws://example.com:8080`| [nn_ws(7)](http://nanomsg.org/v1.0.0/nn_ws.7.html) |

## Example

``` url="external/node/etc/examples/nodes/nanomsg.conf" title="node/etc/examples/nodes/nanomsg.conf"
nodes = {
	nanomsg_node = {
		type = "nanomsg",

		out = {
			endpoints = [
				"tcp://*:12000",		# TCP socket
				"ipc:///tmp/test.ipc",		# Interprocess communication
				"inproc://test"			# Inprocess communication
			],
		}
		in = {
			endpoints = [
				"tcp://127.0.0.1:12000",
				"ipc:///tmp/test.ipc",
				"inproc://test"
			]
		}
	}
}
```
