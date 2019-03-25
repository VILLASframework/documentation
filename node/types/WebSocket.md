# WebSocket {#node-type-websocket}

The `websocket` node type send and receives simulation data via binary WebSocket messages.

[The message format](@ref node-type-socket-format) is the same as used by the @ref node-type-socket node-type.

# Prerequisites {#node-prereq-websocket}

This node-type requires [libwebsockets](http://libwebsockets.org) (>= 2.3.0).

# Implementation {#node-implementation-websocket}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/websocket.c

# Configuration {#node-config-node-websocket}

By default the @ref node-usage-node daemon listens on @ref node-config-http-port for HTTP and WebSocket requests.
This behaviour can be disabled by setting @ref node-config-http-enabled to `false`.

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


## Example

@include node/nodes/websocket.conf
