---
hide_table_of_contents: true
---

# Calculate Jitter

The `jitter_calc` hook calculates the jitter based on inter-sampling time as used in [Wireshark](https://wiki.wireshark.org/RTP_statistics) according to RFC3550. 
The original purpose was to calculate the jitter between the timestamp of a GTNET GPS timestamp and the VILLASNode NTP timestamp. 

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
