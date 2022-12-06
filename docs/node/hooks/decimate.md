---
hide_table_of_contents: true
---

# Decimate sample rate

The `decimate` hook reduces the sampling rate by periodically discarding samples.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/decimate.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/decimate" />

## Example

``` url="external/node/etc/examples/hooks/decimate.conf" title="node/etc/examples/hooks/decimate.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "decimate"

				ratio = 10
			}
		)
	}
)
```
