---
hide_table_of_contents: true
---

# Round signals

The `round` hook rounds selected signals of a sample to a specified number of digits.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/round.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/round" />

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
