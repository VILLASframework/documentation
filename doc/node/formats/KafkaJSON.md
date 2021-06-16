# Kafka Schema/Payload Javascript Object Notation {#node-format-json-kafka}

# Configuration

The @ref node-format-json-kafka format-type supports all configuration options of the @ref node-format-json format-type plus the following:

## schema (object) {#node-config-format-json-kafka-schema}

# Example Configuration

```json
{
  "type": "json.kafka",

  "indent": 2,

  "schema": {
    "type": "struct",
    "name": "villas-node.Value",
  }
}
```

# Example Payload

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

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json_kafka.cpp
