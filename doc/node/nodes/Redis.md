# Redis {#node-type-redis}

# Prerequisites {#node-type-redis-prereq}

This node-type requires [hiredis](https://github.com/redis/hiredis) (>= 1.0.0) and [redis++](https://github.com/sewenew/redis-plus-plus) (>= 1.2.3).

# Implementation {#node-type-redis-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/redis.cpp

# Configuration {#node-config-node-redis}

## mode (string: "getset" | "pubsub" | "streams") = "getset" {#node-config-node-redis-mode}

- [Get](https://redis.io/commands/get)/[Set](https://redis.io/commands/set)
  - Side note: the implementation actually uses the Redis `MSET` and `MGET` commands.
- [Publish/subscribe](https://redis.io/topics/pubsub)
- [Streams](https://redis.io/topics/streams-intro)

**Note:** The `streams` option is currently not yet implemented.
## host (string) = "localhost" {#node-config-node-redis-host}

The hostname or IP address of the Redis server.

You can also connect to Redis server with a URI:

- `tcp://[[username:]password@]host[:port][/db]`
- `unix://[[username:]password@]path-to-unix-domain-socket[/db]`

## port (integer) = 6379 {#node-config-node-redis-port}

The port number of the Redis server to connect to.

## path (string) {#node-config-node-redis-path}

A path of a Unix socket which should be used for the connection.

## user (string) = "default" {#node-config-node-redis-user}

The username which should be used for authentication.

See: https://redis.io/commands/auth

## password (string) {#node-config-node-redis-password}

The password which should be used for authentication.

See: https://redis.io/commands/auth

## db (integer) = 0 {#node-config-node-redis-db}

The logical database which should be used by the Redis client.

See: https://redis.io/commands/select

## timeout.connect (double: seconds) {#node-config-node-redis-timeout-connect}

The timeout in seconds for the initial connection establishment.

## timeout.socket (double: seconds) {#node-config-node-redis-timeout-socket}

The timeout in seconds for executing commands against the Redis server.

## keepalive (boolean) = true {#node-config-node-redis-keepalive}

Enable periodic keepalive packets. 

## prefix (string) = _node-name_ (#node-config-node-redis-prefix)

## events (boolean) = true {#node-config-node-redis-events}

Use Redis keyspace events to listen for new updates.
This setting is only used if @ref node-config-node-redis-mode is set to `setget`.

See: https://redis.io/topics/notifications

## signals (boolean) = true {#node-config-node-redis-signals}

If enabled (default) the node will set/publish to separate keys/channels for each signal of a sample.
If disabled the node will set/publish to a single key/channel defined by @ref node-config-node-redis-prefix with a payload encoded by @ref node-config-node-redis-format.

## ssl.enabled (boolean) = true {#node-config-node-redis-ssl-enabled}

If enabled the connection to the Redis server will be encrypted via SSL/TLS.

## ssl.cacert (string: path) {#node-config-node-redis-ssl-cacert}

A path to a CA certificate file.

## ssl.cacertdir (string: path) {#node-config-node-redis-ssl-cacertdir}

A path to a directory containing CA certificates.

## ssl.cert (string: path) {#node-config-node-redis-ssl-cert}

A path to a client certificate file.

## ssl.key (string: path) {#node-config-node-redis-ssl-key}

A path to the private key file.

# Example {#node-type-redis-example}

@include node/etc/examples/nodes/redis.conf
