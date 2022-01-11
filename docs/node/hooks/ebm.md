---
hide_table_of_contents: true
---

# Energy Based Metric calculation

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/ebm.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/ebm" />

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
