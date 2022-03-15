---
hide_table_of_contents: true
---

# Kafka

The `kafka` node-type uses [librdkafka](https://github.com/edenhill/librdkafka) to produce and consume event stream messages to/from kafka message brokers cluster.

## Prerequisites

This node-type requires [rdkafka](https://github.com/edenhill/librdkafka) (>= 1.5.0).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/kafka.cpp

## Configuration {#config}

### format (string) = "villas.binary"

The payload format which is used to encode and decode exchanged messages.

### server (string)

The bootstrap server {ip}:{port} of the Kafka message brokers cluster.

### protocol (string: "PLAINTEXT" | "SASL_PLAINTEXT" | "SASL_SSL" | "SSL")

The [security protocol](https://kafka.apache.org/24/javadoc/org/apache/kafka/common/security/auth/SecurityProtocol.html) which is used for authentication with the Kafka cluster.

### client_id (string)

The Kafka client identifier.

### ssl.ca (string)

Path to a Certificate Authority (CA) bundle which is used to validate broker server certificate.

### sasl (object)

An object for configuring the SASL authentication against the broker.
This setting is used if [setting `protocol`](#protocol) is on of `SASL_PLAINTEXT` or `SASL_SSL`.

See below for an example.

### in.consume (string)

The Kafka topic to which this node-type will subscribe for receiving messages.

### in.group_id (string)

The group id of the Kafka client used for receiving messages.

### out.produce (string)

The Kafka topic to which this node-type will publish messages.

### timeout (float) = 1.0

A timeout in seconds for the broker connection.

## Example

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
