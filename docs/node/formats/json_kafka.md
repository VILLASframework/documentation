---
hide_table_of_contents: true
---

# Kafka Schema/Payload Javascript Object Notation

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json_kafka.cpp

## Configuration {#config}

The `json.kafka` format-type supports the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/json_kafka" />

## Example Configuration {#example}

@include node/etc/examples/formats/json-kafka.conf

## Example Payload {#payload}

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
