# ZeroMQ {#node-type-zeromq}

The @ref node-type-zeromq node-type exchanges messages via the [ZMTP](https://rfc.zeromq.org/spec:23/ZMTP/) protocol.
It is similiar to the @ref node-type-nanomsg node-type.

> ZeroMQ (also known as ØMQ, 0MQ, or zmq) looks like an embeddable networking library but acts like a concurrency framework. It gives you sockets that carry atomic messages across various transports like in-process, inter-process, TCP, and multicast. You can connect sockets N-to-N with patterns like fan-out, pub-sub, task distribution, and request-reply. It's fast enough to be the fabric for clustered products. Its asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing tasks. It has a score of language APIs and runs on most operating systems. ZeroMQ is from iMatix and is LGPLv3 open source.

The @ref node-type-zeromq node-type implements the [publish/subscribe and radio/dish protocols](http://api.zeromq.org/4-2:zmq-socket).

# Prerequisites {#node-prereq-zeromq}

This node-type requires [libzmq](http://zeromq.org) (>= 2.2.0).

# Implementation {#node-implementation-zeromq}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/zeromq.c

# Configuration {#node-config-node-zeromq}

## format (string) {#node-config-node-zeromq-format}

The payload format which is used to encode and decode exchanged messages.

## filter (string: "pubsub" | "radiodish") {#node-config-node-zeromq-pattern}

## publish (string: uri) {#node-config-node-zeromq-publish}

## subscribe (string / array of strings: uri) {#node-config-node-zeromq-subscribe}

## ipv6 (bool) = false {#node-config-node-zeromq-ipv6}

## CurveZMQ cryptography

**Note:** This feature is currently broken.

You can use the `zmq-keygen` tool to create a new keypair for the following configuration options:

### curve.enabled (bool) = true {#node-config-node-zeromq-ipv6}

Whether or not the encryption is enabled.

### curve.public_key (string: Z85 encoded) {#node-config-node-zeromq-curve-public_key}

The public key of the server.

### curve.private_key (string: Z85 encoded) {#node-config-node-zeromq-curve-public_key}

The private key of the server.

## Example

```
nodes = {
	zeromq_node = {
		type = "zeromq",

		pattern = "pubsub",			# The ZeroMQ pattern. One of: 'pubsub', 'radiodish'
		ipv6 = false,				# Enable IPv6 support
		filter = "ab184",			# A filter which is prefix matched
		curve = {				# Z85 encoded Curve25519 keys
			enabled = true,
			public_key = "Veg+Q.V-c&1k>yVh663gQ^7fL($y47gybE-nZP1L",
			secret_key = "HPY.+mFuB[jGs@(zZr6$IZ1H1dZ7Ji*j>oi@O?Pc"
		}

		subscribe = "tcp://*:1234"		# The subscribe endpoint. See http://api.zeromq.org/2-1:zmq-bind for details.
		publish = [				# The publish endpoints. See http://api.zeromq.org/2-1:zmq-connect for details.
			"tcp://localhost:1235",
			"tcp://localhost:12444"
		],
	}
}
```
