# MQTT {#node-type-mqtt}

The @ref node-type-mqtt node-type uses [libmosquitto] to publish and subscribe messages via the [MQTT](http://mqtt.org) protocol. It is similiar to the @ref node-type-amqp node-type.

# Configuration {#node-config-mqtt}

## format (string) {#node-config-mqtt-format}

The payload format which is used to encode and decode exchanged messages.

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

		publish = "test-topic",
		subscribe = "test-topic",

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