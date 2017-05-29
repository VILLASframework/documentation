# WebSocket {#node-type-websocket}

The `websocket` node type send and receives simulation data via binary WebSocket messages.

[The message format](@ref node-type-socket-format) is the same as used by the @ref node-type-socket node-type.

# Configuration {#node-config-websocket}

## destinations (array of URIs) {#node-config-websocket-destinations}

During startup connect to those websocket servers as a client. 

## Example

```
nodes = {
	ws = {
		type = "websocket"
		
		destinations = [
			"ws://someserver:8080/somenode"
		]
	}
}

http = {
	port = 8080;
	htdocs = "/villas/contrib/websocket/";
	ssl_cert = "/etc/ssl/certs/mycert.pem";
	ssl_private_key= "/etc/ssl/private/mykey.pem";
}
```