---
hide_table_of_contents: true
---

# Redis

## Prerequisites

This node-type requires [hiredis](https://github.com/redis/hiredis) (>= 1.0.0) and [redis++](https://github.com/sewenew/redis-plus-plus) (>= 1.2.3).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/redis.cpp

## Configuration {#config}

### mode (string: "key" | "hash" | "channel") = "key"

- `key`: [Get](https://redis.io/commands/get)/[Set](https://redis.io/commands/set) of [Redis strings](https://redis.io/topics/data-types#strings)
  - The implementation uses the Redis `MSET` and `MGET` commands.
- `hash`: Hashtables using [hash data-type](https://redis.io/topics/data-types#hashes)
  - The implementation uses the Redis `HMSET` and `HGETALL` commands.
- `channel`: [Publish/subscribe](https://redis.io/topics/pubsub)
  - The implementation uses the Redis `PUBLISH` and `SUBSCRIBE` commands.

### uri (string: _Redis URI_)

A Redis connection URI in the form of: `redis://<user>:<password>@<host>:<post>/<db>`.

### host (string) = "localhost"

The hostname or IP address of the Redis server.

You can also connect to Redis server with a URI:

- `tcp://[[username:]password@]host[:port][/db]`
- `unix://[[username:]password@]path-to-unix-domain-socket[/db]`

### port (integer) = 6379

The port number of the Redis server to connect to.

### path (string)

A path of a Unix socket which should be used for the connection.

### user (string) = "default"

The username which should be used for authentication.

See: https://redis.io/commands/auth

### password (string)

The password which should be used for authentication.

See: https://redis.io/commands/auth

### db (integer) = 0

The logical database which should be used by the Redis client.

See: https://redis.io/commands/select

### timeout.connect (double: seconds)

The timeout in seconds for the initial connection establishment.

### timeout.socket (double: seconds)

The timeout in seconds for executing commands against the Redis server.

### keepalive (boolean) = false

Enable periodic keepalive packets. 

### key (string) = _node-name_

The key which this node will use in the Redis keyspace.

### channel (string) = _node-name_ 

The channel which this node will use when [`mode` setting](#mode) is `channel`.

### notify (boolean) = true

Use [Redis keyspace notifications](https://redis.io/topics/notifications) to listen for new updates.
This setting is only used if [setting `mode`](#mode) is set to `key` or `hash`.

### ssl.enabled (boolean) = true

If enabled the connection to the Redis server will be encrypted via SSL/TLS.

### ssl.cacert (string: path)

A path to a CA certificate file.

### ssl.cacertdir (string: path)

A path to a directory containing CA certificates.

### ssl.cert (string: path)

A path to a client certificate file.

### ssl.key (string: path)

A path to the private key file.

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
