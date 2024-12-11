---
hide_table_of_contents: true
---

# Cast Signal VSalues

The `cast` hook casts the data-type of signals and can set a new name and unit to the casted signal.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/cast.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/cast" />

## Example

``` url="external/node/etc/examples/hooks/cast.conf" title="node/etc/examples/hooks/cast.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "cast"

				signal = "random"
				
				new_name = "int_random"
				new_unit = "pts"
				new_type = "integer"
			}
		)
	}
)
```
