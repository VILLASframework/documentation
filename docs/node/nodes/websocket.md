# WebSocket {#node-type-websocket}

The `websocket` node type send and receives simulation data via binary WebSocket messages.

# Prerequisites {#node-type-websocket-prereq}

This node-type requires [libwebsockets](http://libwebsockets.org) (>= 2.3.0).

# Implementation {#node-type-websocket-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/websocket.cpp

# Configuration {#node-config-node-websocket}

By default the [`villas node`](../usage/villas-node.md) daemon listens on [`http.port`](../config/http.md#port) for HTTP and WebSocket requests.
This behaviour can be disabled by setting [`http.enabled`](../config/http.md#) to `false`.

## destinations (array of URIs) {#node-config-node-websocket-destinations}

During startup connect to those WebSocket servers as a client.

Each URI must use the following scheme:

```
protocol://host:port/nodename
```

It starts with a protocol which must be one of `ws` (unencrypted) or `wss` (SSL).
The host name or IP address is separated by `://`.
The optional port number is separated by a colon `:`.
The node name is separated by a slash `/`.

# Example {#node-type-websocket-example}

@include node/etc/examples/nodes/websocket.conf
