---
hide_table_of_contents: true
---

# Javascript Object Notation

**Specification:** http://json.org

## Implementation

The source code of the format-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/formats/json.cpp

## Configuration {#config}

The `json` format-type supports the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/json" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/json.conf" title="node/etc/examples/formats/json.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = {
			type = "json"

			indent = 4
			compact = true
			ensure_ascii = true
			escape_slash = false
			sort_keys = true
		}
	}
}
```

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
