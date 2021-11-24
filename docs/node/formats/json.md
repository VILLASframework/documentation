# Javascript Object Notation

**Specification:** http://json.org

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json.cpp

## Configuration {#config}

The `json` format-type supports the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema
  specUrl="external/node/doc/dist.yaml"
  schemaRef="#/components/schemas/json"
/>

## Example Payload {#payload}

The structure of the JSON format is closely aligned with VILLASnode's internal data representation.

```json
[
  {
    "ts": {
      "origin": [
        1556787289,
        492436800
      ]
    },
    "sequence": 55,
    "data": [
      0.022245,
      -1,
      true,
      {
          "real": 1.23,
          "imag": 4.56
      }
    ]
  }
]
```
