---
hide_table_of_contents: true
---

# WebSocket

The `websocket` node type send and receives simulation data via binary WebSocket messages.

## Prerequisites

This node-type requires [libwebsockets](http://libwebsockets.org) (>= 2.3.0).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/websocket.cpp

## Configuration {#config}

By default the [`villas node`](../usage/villas-node.md) daemon listens on [`http.port`](../config/http.md) for HTTP and WebSocket requests.
This behavior can be disabled by setting [`http.enabled`](../config/http.md#) to `false`.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/websocket" />

## Example

``` url="external/node/etc/examples/nodes/websocket.conf" title="node/etc/examples/nodes/websocket.conf"
nodes = {
	ws = {
		type = "websocket"

		destinations = [
			"ws://someserver:8080/somenode"
		]
	}
}

http = {
	port = 8080
	ssl_cert = "/etc/ssl/certs/mycert.pem"
	ssl_private_key= "/etc/ssl/private/mykey.pem"
}
```
