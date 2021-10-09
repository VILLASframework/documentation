# Kafka Schema/Payload Javascript Object Notation {#node-format-json-kafka}

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json_kafka.cpp

# Configuration {#node-config-format-json-kafka}

The @ref node-format-json-kafka format-type supports all configuration options of the @ref node-format-json format-type plus the following:

## schema (object) {#node-config-format-json-kafka-schema}

# Example Configuration {#node-format-json-kafka-example}

@include node/etc/examples/formats/json-kafka.conf

# Example Payload {#node-format-json-kafka-payload}

```json
{
  "schema": {
    "type": "struct",
    "name": "villas-node.Value",
    "fields": [
      {
        "type": "int64",
        "optional": false,
        "field": "timestamp"
      },
      {
        "type": "int64",
        "optional": false,
        "field": "sequence"
      },
      {
        "type": "double",
        "optional": false,
        "field": "signal0"
      }
    ]
  },
  "payload": {
    "timestamp": 1623834103174,
    "sequence": 7,
    "signal0": -0.95122443954003999
  }
}
```
