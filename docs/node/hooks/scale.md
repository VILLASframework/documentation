---
hide_table_of_contents: true
---

# Scale and Offset Signals

The `scale` hook modifies sample signals by a gain factor and optionally ads an offset.
First the original signal value is multiplied by the gain, then the offset is added.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/scale.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/scale" />

## Example

``` url="external/node/etc/examples/hooks/scale.conf" title="node/etc/examples/hooks/scale.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "scale"

				signal = "sine"

				offset = 100.0
				scale = 55.0
			}
		)
	}
)
```
