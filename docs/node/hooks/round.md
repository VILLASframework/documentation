---
hide_table_of_contents: true
---

# Round signals

The `round` hook modifies sample signals by a gain factor and optionally ads an offset.
First the original signal value is multiplied by the gain, then the offset is added.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/round.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/round" />

## Example

``` url="external/node/etc/examples/hooks/round.conf" title="node/etc/examples/hooks/round.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "round"

				signal = "sine"

				precision = 4
			}
		)
	}
)
```
