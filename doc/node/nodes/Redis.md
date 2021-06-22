# Redis {#node-type-redis}

# Prerequisites {#node-prereq-redis}

This node-type requires [hiredis](https://github.com/redis/hiredis) (>= 1.0.0) and [redis++](https://github.com/sewenew/redis-plus-plus) (>= 1.2.3).

# Implementation {#node-implementation-redis}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/redis.cpp

# Configuration {#node-config-node-redis}

## mode (string: "getset") = "getset" {#node-config-node-redis-mode}

## host (string) {#node-config-node-redis-host}

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

## db (integer) = 0 {#node-config-redis-db}

The logical database which should be used by the Redis client.

See: https://redis.io/commands/select

## timeout.connect (double: seconds) {#node-config-redis-timeout-connect}

The timeout in seconds for the initial connection establishment.

## timeout.socket (double: seconds) {#node-config-redis-timeout-socket}

The timeout in seconds for executing commands against the Redis server.

## keepalive (boolean) = true {#node-config-redis-keepalive}

Enable periodic keepalive packets. 

## ssl.enabled (boolean) = true {#node-config-node-redis-ssl-enabled}

## ssl.cacert (string: filename) {#node-config-node-redis-ssl-cacert}

## ssl.cacertdir (string: directory) {#node-config-node-redis-ssl-cacertdir}

## ssl.cert (string: filename) {#node-config-node-redis-ssl-cert}

## ssl.key (string:filename) {#node-config-node-redis-ssl-key}

## Example

@include node/etc/examples/nodes/redis.conf
