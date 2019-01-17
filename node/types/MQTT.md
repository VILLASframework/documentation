# MQTT {#node-type-mqtt}

The @ref node-type-mqtt node-type uses [libmosquitto] to publish and subscribe messages via the [MQTT](http://mqtt.org) protocol. It is similiar to the @ref node-type-amqp node-type.

# Prerequisites {#node-prereq-mqtt}

This node-type requires [mosquitto](https://mosquitto.org) (>= 1.4.15).

# Implementation {#node-implementation-mqtt}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/mqtt.c

# Configuration {#node-config-mqtt}

## format (string) {#node-config-mqtt-format}

The payload format which is used to encode and decode exchanged messages.

## username (string) {#node-config-mqtt-username}

The username which is used for authentication with the MQTT broker.

## password (string) {#node-config-mqtt-password}

The password which is used for authentication with the MQTT broker.

## host (string) {#node-config-mqtt-host}

The hostname of the MQTT broker.

## port (integer) = 1883 {#node-config-mqtt-port}

The port number of the MQTT broker.


## retain (boolean) = false {#node-config-mqtt-retain}

## keepalive (integer) = 1 {#node-config-mqtt-keepalive}

## qos (integer) = 0 {#node-config-mqtt-qos}

## Example

```
nodes = {
	mqtt_node = {
		type = "mqtt",

		format = "protobuf",

		username = "guest",
		password = "guest",
		host = "localhost",
		port = 1883,

		keepalive = 5,
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
