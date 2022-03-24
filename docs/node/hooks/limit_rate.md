---
hide_table_of_contents: true
---

# Limit rate

The `limit_rate` hook discards samples in order to limit the sample rate to a certain rate.
The decision whether a sample is discarded or not is based on its timestamp.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/limit_rate.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/limit_rate" />

## Example

``` url="external/node/etc/examples/hooks/limit_rate.conf" title="node/etc/examples/hooks/limit_rate.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "limit_rate"

				rate = 5.5
			}
		)
	}
)
```
