---
hide_table_of_contents: true
---

# HTTP / WebSocket server {#node-config-http}

## Example

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

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/http" />
