---
hide_table_of_contents: true
---

# Timestamp

The `ts` hook overwrite the origin timestamp field of each sample with the current system time.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/ts.cpp

## Configuration

The `ts` hook has no configurable options.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/ts" />

## Example

``` url="external/node/etc/examples/hooks/ts.conf" title="node/etc/examples/hooks/ts.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "ts"
			}
		)
	}
)
```
