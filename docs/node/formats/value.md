---
hide_table_of_contents: true
---

# Single value text

The `value` format-type encodes a single sample value in a human readable representation.

**Note:** It currently only supports encoding of samples with a single signal!

## Implementation

The source code of the format-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/formats/value.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/value" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/value.conf" title="node/etc/examples/formats/value.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = {
			type = "value"

			real_precision = 5
		}
	}
}
```
