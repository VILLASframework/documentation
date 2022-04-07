---
hide_table_of_contents: true
---

# Skip First Samples

The `skip_first` hook discards the first samples of a simulation case.
It can either drop the first `n` samples or drop the first `n` seconds of a case.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/skip_first.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/skip_first" />

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
