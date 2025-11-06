---
sidebar_label: MQTT
hide_table_of_contents: true
---

# Message Queuing Telemetry Transport (MQTT)

The `mqtt` node-type uses [libmosquitto] to publish and subscribe messages via the [MQTT](http://mqtt.org) protocol. It is similar to the [`amqp` node-type](amqp.md).

## Prerequisites

This node-type requires [mosquitto](https://mosquitto.org) (>= 1.4.15).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/mqtt.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/mqtt" />

## Example

``` url="external/node/etc/examples/nodes/mqtt.conf" title="node/etc/examples/nodes/mqtt.conf"
nodes = {
    mqtt_node = {
        type = "mqtt"

        format = "protobuf"

        username = "guest"
        password = "guest"
        host = "localhost"
        port = 1883

        # Send ping every 5 seconds to keep connection alive
        keepalive = 5
        retain = false
        qos = 0

        out = {
            publish = "test-topic"
        }

        in = {
            subscribe = "test-topic"
        }

        ssl = {
            enabled = false
            insecure = true
            cafile = "/etc/ssl/certs/ca-bundle.crt"
            certfile = "/etc/ssl/certs/my.crt"
            keyfile = "/etc/ssl/keys/my.key"
        }
    }
}
```
