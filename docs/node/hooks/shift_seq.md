---
hide_table_of_contents: true
---

# Shift sequence numbers

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/shift_seq.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/shift_seq" />

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
