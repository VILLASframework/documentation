# MQTT {#node-type-mqtt}

The @ref node-type-mqtt node-type uses [libmosquitto] to publish and subscribe messages via the [MQTT](http://mqtt.org) protocol. It is similiar to the @ref node-type-amqp node-type.

# Prerequisites {#node-type-mqtt-prereq}

This node-type requires [mosquitto](https://mosquitto.org) (>= 1.4.15).

# Implementation {#node-type-mqtt-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/mqtt.cpp

# Configuration {#node-config-node-mqtt}

## format (string) {#node-config-node-mqtt-format}

The payload format which is used to encode and decode exchanged messages.

## username (string) {#node-config-node-mqtt-username}

The username which is used for authentication with the MQTT broker.

## password (string) {#node-config-node-mqtt-password}

The password which is used for authentication with the MQTT broker.

## host (string) {#node-config-node-mqtt-host}

The hostname of the MQTT broker.

## port (integer) = 1883 {#node-config-node-mqtt-port}

The port number of the MQTT broker.


## retain (boolean) = false {#node-config-node-mqtt-retain}

## keepalive (integer) = 1 {#node-config-node-mqtt-keepalive}

## qos (integer) = 0 {#node-config-node-mqtt-qos}

## Example

@include node/etc/examples/nodes/mqtt.conf
