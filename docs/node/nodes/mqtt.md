---
hide_table_of_contents: true
---

# MQTT

The `mqtt` node-type uses [libmosquitto] to publish and subscribe messages via the [MQTT](http://mqtt.org) protocol. It is similiar to the [`amqp` node-type](amqp.md).

## Prerequisites

This node-type requires [mosquitto](https://mosquitto.org) (>= 1.4.15).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/mqtt.cpp

## Configuration {#config}

### format (string)

The payload format which is used to encode and decode exchanged messages.

### username (string)

The username which is used for authentication with the MQTT broker.

### password (string)

The password which is used for authentication with the MQTT broker.

### host (string)

The hostname of the MQTT broker.

### port (integer) = 1883

The port number of the MQTT broker.

### retain (boolean) = false

### keepalive (integer) = 1

### qos (integer) = 0

## Example

``` url="external/node/etc/examples/nodes/mqtt.conf" title="node/etc/examples/nodes/mqtt.conf"
nodes = {
	mqtt_node = {
		type = "mqtt",
		
		format = "protobuf",
		
		username = "guest",
		password = "guest",
		host = "localhost",
		port = 1883,
		
		keepalive = 5,				# Send ping every 5 seconds to keep connection alive
		retain = false,
		qos = 0,

		out = {
			publish = "test-topic"
		},
		in = {
			subscribe = "test-topic"
		},
		ssl = {
			enabled = false,
			insecure = true,
			cafile = "/etc/ssl/certs/ca-bundle.crt",
			certfile = "/etc/ssl/certs/my.crt",
			keyfile = "/etc/ssl/keys/my.key"
		}
	}
}
```
