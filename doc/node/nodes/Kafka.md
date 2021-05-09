# Kafka {#node-type-kafka}

The @ref node-type-kafka node-type uses [librdkafka](https://github.com/edenhill/librdkafka) to produce and consume event stream messages to/from kafka message brokers cluster.

# Prerequisites {#node-prereq-kafka}

This node-type requires [rdkafka](https://github.com/edenhill/librdkafka) (>= 1.5.0).

# Implementation {#node-implementation-kafka}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/kafka.cpp

# Configuration {#node-config-node-kafka}

## format (string) {#node-config-node-kafka-format}

The payload format which is used to encode and decode exchanged messages.

## server (string) {#node-config-node-kafka-server}

The bootstrap server {ip}:{port} of the Kafka message brokers cluster.

## protocol (string) {#node-config-node-kafka-protocol}

The [security protocol](https://kafka.apache.org/24/javadoc/org/apache/kafka/common/security/auth/SecurityProtocol.html) which is used for authentication with the Kafka cluster.

## client_id (string) {#node-config-node-kafka-client_id}

The Kafka client identifier.

## timeout (integer) = 1000 {#node-config-node-kafka-timeout}

## Example

@include node/etc/examples/nodes/kafka.conf
