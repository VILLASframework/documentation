---
hide_table_of_contents: true
---

# Energy Based Metric Calculation

The `ebm` hook calculates the energy consumption based on voltage and current samples over time.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/ebm.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/ebm" />

## Example

``` url="external/node/etc/examples/hooks/ebm.conf" title="node/etc/examples/hooks/ebm.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "ebm"

				phases = (
					[ 0, 1 ],
					[ 2, 3 ],
					[ 4, 5 ]
				)
			}
		)
	}
)
```
