---
hide_table_of_contents: true
---

# ZeroMQ

The `zeromq` node-type exchanges messages via the [ZMTP](https://rfc.zeromq.org/spec:23/ZMTP/) protocol.
It is similar to the [`nanomsg`](nanomsg.md) node-type.

> ZeroMQ (also known as ØMQ, 0MQ, or zmq) looks like an embeddable networking library but acts like a concurrency framework. It gives you sockets that carry atomic messages across various transports like in-process, inter-process, TCP, and multicast. You can connect sockets N-to-N with patterns like fan-out, pub-sub, task distribution, and request-reply. It's fast enough to be the fabric for clustered products. Its asynchronous I/O model gives you scalable multicore applications, built as asynchronous message-processing tasks. It has a score of language APIs and runs on most operating systems. ZeroMQ is from iMatix and is LGPLv3 open source.

The `zeromq` node-type implements the [publish/subscribe and radio/dish protocols](http://api.zeromq.org/4-2:zmq-socket).

## Prerequisites

This node-type requires [libzmq](http://zeromq.org) (>= 2.2.0).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/zeromq.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/websocket" />

## Example

``` url="external/node/etc/examples/nodes/zeromq.conf" title="node/etc/examples/nodes/zeromq.conf"
nodes = {
    zeromq_node = {
        type = "zeromq"

        # The ZeroMQ pattern. One of pubsub, radiodish
        pattern = "pubsub"

        # Enable IPv6 support
        ipv6 = false

        # Z85 encoded Curve25519 keys
        curve = {
            enabled = false
            public_key = "Veg+Q.V-c&1k>yVh663gQ^7fL($y47gybE-nZP1L"
            secret_key = "HPY.+mFuB[jGs@(zZr6$IZ1H1dZ7Ji*j>oi@O?Pc"
        }

        in = {
            # The subscribe endpoint
            # See http://api.zeromq.org/2-1:zmq-bind for details
            subscribe = "tcp://*:1234"

            # A filter which is prefix matched for each received msg
            filter = "ab184"
        }
        out = {
            # The publish endpoints
            # See http://api.zeromq.org/2-1:zmq-connect for details
            publish = [

                "tcp://localhost:1235",
                "tcp://localhost:12444"
            ]

            # A prefix which is pre-pended to each message
            filter = "ab184"
        }
    }
}
```
