---
hide_table_of_contents: true
---

# Kafka

The `kafka` node-type uses [librdkafka](https://github.com/edenhill/librdkafka) to produce and consume event stream messages to/from kafka message brokers cluster.

## Prerequisites

This node-type requires [rdkafka](https://github.com/edenhill/librdkafka) (>= 1.5.0).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/kafka.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/kafka" />

## Example

``` url="external/node/etc/examples/nodes/kafka.conf" title="node/etc/examples/nodes/kafka.conf"
nodes = {
    kafka_node = {
        type = "kafka"

        format = "json.kafka"

        server = "localhost:9094"
        protocol = "SASL_SSL"
        client_id = "villas-node"

        in = {
            consume = "test-topic"
            group_id = "villas-node"
        }

        out = {
            produce = "test-topic"
        }

        ssl = {
            ca = "/etc/ssl/certs/ca.pem"
        }

        sasl = {
            mechanisms = "SCRAM-SHA-512"
            username = "scram-sha-512-usr"
            password = "scram-sha-512-pwd"
        }
    }
}
```
