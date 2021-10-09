# HTTP / WebSocket server {#node-config-http}

# Example {#node-config-http-example}

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

# Configuration

### http.enabled (boolean) = true {#node-config-http-enabled}

When set to `false` the VILLASnode daemon will not listen on a port for servering HTTP and WebSocket requests.

### http.htdocs (string: path) = "/usr/share/villas/node/web"  {#node-config-http-htdocs}

The location of of static files served by the HTTP / WebSocket server.

### http.port (integer)  = 80 {#node-config-http-port}

The TCP port number on which HTTP / WebSocket server.

### http.ssl_cert (string: path) {#node-config-ssl_cert}

The public x509 certificate used for server-side SSL encryption.

### http.ssl_private_key (string: path) {#node-config-ssl_private_key}

The private x509 certificate used for server-side SSL encryption.


