---
hide_table_of_contents: true
---

# Dump Sample Data

The `dump` hook will print a detailed dump of each processes samples to the standard output.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/dump.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/dump" />

## Example

``` url="external/node/etc/examples/hooks/dump.conf" title="node/etc/examples/hooks/dump.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "dump"
			}
		)
	}
)
```
