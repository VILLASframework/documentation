---
hide_table_of_contents: true
---

# Redis

## Prerequisites

This node-type requires [hiredis](https://github.com/redis/hiredis) (>= 1.0.0) and [redis++](https://github.com/sewenew/redis-plus-plus) (>= 1.2.3).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/redis.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/redis" />

## Example

``` url="external/node/etc/examples/nodes/redis.conf" title="node/etc/examples/nodes/redis.conf"
nodes = {
	redis_node = {
		type = "redis",

		format = "json",		# only valid for mode = 'channel' and 'key'
						# With mode = 'hash' we will use a simple human readable format

		key = "my_key"			# The Redis key to be used for mode = 'key' or 'hash' (default is the node name)
		channel = "my_channel"		# the Redis channel tp be used for mode = 'channel' (default is the node name)

		mode = "key",			# one of:
						# - 'channel' (publish/subscribe)
						# - 'key'     (set/get)
						# - 'hash'    (hmset/hgetall)

		notify = false			# Whether or not to use Redis keyspace event notifications to get notified about updates
		
		rate = 1.0			# The polling rate when notify = false

		uri = "tcp://localhost:6379/0",	# The Redis connection URI

		# host = "localhost"		# Alternatively the connection options can be specified independently
		# port = 6379			# Note: options here will overwrite the respective part of the URI if both are given.
		# db = 0

		# path = "/var/run/redis.sock"

		# user = "guest",
		# password = "guest"

		# ssl = {
		#	enabled: true
		#	cacert: "/etc/ssl/certs/ca-certificates.crt",
		#	cacertdir: "/etc/ssl/certs"
		#	cert: "./my_cert.crt",
		#	key, "./my_key.key"
		# }
	}
}
```
