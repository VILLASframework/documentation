---
hide_table_of_contents: true
---

# Shift Sequence Numbers

The `shift_seq` hook is designed to modify the sequence number of samples.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/shift_seq.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/shift_seq" />

## Example

``` url="external/node/etc/examples/hooks/shift_seq.conf" title="node/etc/examples/hooks/shift_seq.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "shift_seq"

				offset = 10
			}
		)
	}
)
```
