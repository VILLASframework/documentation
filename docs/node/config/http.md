# Embedded HTTP / WebSocket server

## Configuration

### http.enabled (boolean) = true {#enabled}

When set to `false` the VILLASnode daemon will not listen on a port for servering HTTP and WebSocket requests.

### http.port (integer)  = 80 {#port}

The TCP port number on which HTTP / WebSocket server.

### http.ssl_cert (string: path) {#ssl_cert}

The public x509 certificate used for server-side SSL encryption.

### http.ssl_private_key (string: path) {#ssl_private_key}

The private x509 certificate used for server-side SSL encryption.

## Example {#example}

<!-- TODO: Convert to json -->
```
http = {
	enabled = true,					# Do not listen on a port if false

	htdocs = "/villas/web/socket/",			# Root directory of internal webserver
	port = 80					# Port for HTTP connections

	ssl_cert = "/etc/ssl/certs/mycert.pem";
	ssl_private_key= "/etc/ssl/private/mykey.pem";
}
```
