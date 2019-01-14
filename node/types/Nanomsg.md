# nanomsg {#node-type-nanomsg}

The @ref node-type-nanomsg node-type uses [libzmq] to exchange messages via the [ZMTP](https://rfc.nanomsg.org/spec:23/ZMTP/) protocol. It is similiar to the @ref node-type-zeromq node-type.

> nanomsg is a socket library that provides several common communication patterns. It aims to make the networking layer fast, scalable, and easy to use. Implemented in C, it works on a wide range of operating systems with no further dependencies.

The @ref node-type-nanomsg node-type only implements the [publish-subscribe protocol](http://nanomsg.org/v1.0.0/nn_pubsub.7.html) provided by nanomsg.

# Implementation {#node-implementation-nanomsg}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/nanomsg.c

# Configuration {#node-config-nanomsg}

## format (string) {#node-config-nanomsg-format}

The payload format which is used to encode and decode exchanged messages.

## publish (string / array of strings: uri) {#node-config-nanomsg-publish}

A single endpoint URI or list of URIs on which this node should listen for subscribers.

## subscribe (string / array of strings: uri) {#node-config-nanomsg-subscribe}

A single endpoint URI or list of URIs pointing to which this node should connect to as a subscriber.

## Endpoints

The @ref node-type-nanomsg supports several different transport mechanisms which are listed in the following table:

| Name	| URI example		| Documentation									|
| :--		| :--					| :--												|
| In-process transport | `inproc://test` 	| [nn_inproc(7)](http://nanomsg.org/v1.0.0/nn_inproc.7.html) |
| Inter-process transport | `ipc:///tmp/test.ipc` | [nn_ipc(7)](http://nanomsg.org/v1.0.0/nn_ipc.7.html) |
| TCP transport | `tcp://1.1.1.1:456`	| [nn_tcp(7)](http://nanomsg.org/v1.0.0/nn_tcp.7.html) |
| WebSocket transport | `ws://example.com:8080`| [nn_ws(7)](http://nanomsg.org/v1.0.0/nn_ws.7.html) |

## Example

```
nodes = {
	nanomsg_node = {
		type = "nanomsg",

		publish = [
			"tcp://*:12000",		# TCP socket
			"ipc:///tmp/test.ipc",		# Interprocess communication
			"inproc://test"			# Inprocess communication
		],
		subscribe = [
			"tcp://127.0.0.1:12000",
			"ipc:///tmp/test.ipc",
			"inproc://test"
		]
	},
}
```
