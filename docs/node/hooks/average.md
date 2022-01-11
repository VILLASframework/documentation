---
hide_table_of_contents: true
---

# Average signal values

The `average` hook calculates arithmetic mean over a set of signals and insert it as a new value to the samples.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/average.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/average" />

## Example

``` url="external/node/etc/examples/hooks/average.conf" title="node/etc/examples/hooks/average.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "average"

				signals = [ "sine", "square" ]
				offset = 0
			}
		)
	}
)
```
