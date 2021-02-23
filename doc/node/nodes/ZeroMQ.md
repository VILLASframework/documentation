# ZeroMQ {#node-type-zeromq}

The @ref node-type-zeromq node-type exchanges messages via the [ZMTP](https://rfc.zeromq.org/spec:23/ZMTP/) protocol.
It is similiar to the @ref node-type-nanomsg node-type.

> ZeroMQ (also known as ØMQ, 0MQ, or zmq) looks like an embeddable networking library but acts like a concurrency framework. It gives you sockets that carry atomic messages across various transports like in-process, inter-process, TCP, and multicast. You can connect sockets N-to-N with patterns like fan-out, pub-sub, task distribution, and request-reply. It's fast enough to be the fabric for clustered products. Its asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing tasks. It has a score of language APIs and runs on most operating systems. ZeroMQ is from iMatix and is LGPLv3 open source.

The @ref node-type-zeromq node-type implements the [publish/subscribe and radio/dish protocols](http://api.zeromq.org/4-2:zmq-socket).

# Prerequisites {#node-prereq-zeromq}

This node-type requires [libzmq](http://zeromq.org) (>= 2.2.0).

# Implementation {#node-implementation-zeromq}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/zeromq.cpp

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

@include node/etc/examples/nodes/zeromq.conf
