---
hide_table_of_contents: true
---

# Dynamic Phasor calculation / DFT

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/dp.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/dp" />

## Example

``` url="external/node/etc/examples/hooks/dp.conf" title="node/etc/examples/hooks/dp.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "dp"

				signal = "sine"
				f0 = 50 # Hz
				dt = 0.1 # seconds
				
				# Alternative to dt
				# rate = 10 Hz

				harmonics = [ 0, 1, 3, 5, 7 ]
				inverse = false
			}
		)
	}
)
```
