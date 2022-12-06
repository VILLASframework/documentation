---
hide_table_of_contents: true
---

# Calculate Jitter

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/jitter_calc.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/jitter_calc" />

## Example

``` url="external/node/etc/examples/hooks/jitter_calc.conf" title="node/etc/examples/hooks/jitter_calc.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "jitter_calc"
			}
		)
	}
)
```
