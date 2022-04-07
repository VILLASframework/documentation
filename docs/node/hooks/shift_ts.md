---
hide_table_of_contents: true
---

# Shift timestamps

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/shift_ts.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/shift_ts" />

## Example

``` url="external/node/etc/examples/hooks/shift_ts.conf" title="node/etc/examples/hooks/shift_ts.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "shift_ts"

				mode = "origin"
				offset = 5.5
			}
		)
	}
)
```
