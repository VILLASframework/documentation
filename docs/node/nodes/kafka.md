# Kafka {#node-type-kafka}

The `kafka` node-type uses [librdkafka](https://github.com/edenhill/librdkafka) to produce and consume event stream messages to/from kafka message brokers cluster.

# Prerequisites {#node-type-kafka-prereq}

This node-type requires [rdkafka](https://github.com/edenhill/librdkafka) (>= 1.5.0).

# Implementation {#node-type-kafka-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/kafka.cpp

# Configuration {#node-config-node-kafka}

## format (string) = "villas.binary" {#node-config-node-kafka-format}

The payload format which is used to encode and decode exchanged messages.

## server (string) {#node-config-node-kafka-server}

The bootstrap server {ip}:{port} of the Kafka message brokers cluster.

## protocol (string: "PLAINTEXT" | "SASL_PLAINTEXT" | "SASL_SSL" | "SSL") {#node-config-node-kafka-protocol}

The [security protocol](https://kafka.apache.org/24/javadoc/org/apache/kafka/common/security/auth/SecurityProtocol.html) which is used for authentication with the Kafka cluster.

## client_id (string) {#node-config-node-kafka-client_id}

The Kafka client identifier.

## ssl.ca (string) {#node-config-node-kafka-ssl}

Path to a Certificate Authority (CA) bundle which is used to validate broker server certificate.
## sasl (object) {#node-config-node-kafka-sasl}

An object for configuring the SASL authentication against the broker.
This setting is used if [setting `protocol`](#protocol) is on of `SASL_PLAINTEXT` or `SASL_SSL`.

See below for an example.

## in.consume (string)

The Kafka topic to which this node-type will subscribe for receiving messages.

## in.group_id (string)

The group id of the Kafka client used for receiving messages.

## out.produce (string)

The Kafka topic to which this node-type will publish messages.

## timeout (float) = 1.0 {#node-config-node-kafka-timeout}

A timeout in seconds for the broker connection.

# Example {#node-type-kafka-example}

``` url="external/node/etc/examples/nodes/kafka.conf" title="node/etc/examples/nodes/kafka.conf"
nodes = {
	kafka_node = {
		type = "kafka",
		
		format = "json.kafka",

		server = "localhost:9094",
		protocol = "SASL_SSL",
		client_id = "villas-node",

		in = {
			consume = "test-topic",
			group_id = "villas-node"
		},
		out = {
			produce = "test-topic"
		},

		ssl = {
			ca = "/etc/ssl/certs/ca.pem",
		},
		sasl = {
			mechanisms = "SCRAM-SHA-512",
			username = "scram-sha-512-usr",
			password = "scram-sha-512-pwd"
		}
	}
}
```
