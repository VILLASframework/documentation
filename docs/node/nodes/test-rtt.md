---
hide_table_of_contents: true
---

# Test Round-trip Time

The `test_rtt` node-type is a virtual node-type which can be used to measure round-trip time to other nodes.
The `test_rtt` nodes periodically generate probes which must be looped back via a second node.

:::info Hint for UDP `socket` node-type
If you want to use the UDP `socket` node-type, you need to use the `raw` format type and set `fake = true` in the configuration file. 
In that way, you make sure that the timestamp is set correctly. 
:::

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/test_rtt.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/test_rtt" />

## Example

``` url="external/node/etc/examples/nodes/test_rtt.conf" title="node/etc/examples/nodes/test_rtt.conf"
nodes = {
	rtt_node = {					# The "test_rtt" node-type runs a set of test cases for varying
		type = "test_rtt",			# sending rates, number of values and generates statistics.
		cooldown = 2,				# The cooldown time between each test case in seconds
		
		prefix = "test_rtt_%y-%m-%d_%H-%M-%S",			# An optional prefix in the filename
		output = "./results",		# The output directory for all results
							# The results of each test case will be written to a separate file.
		format = "villas.human",		# The output format of the result files.

		cases = (				# The list of test cases
							# Each test case can specify a single or an array of rates and values
							# If arrays are used, we will generate multiple test cases with all
							# possible combinations
			{
				rates = 55.0,		# The sending rate in Hz
				values = [ 5, 10, 20],		# The number of values which should be send in each sample
				limit = 100		# The number of samples which should be send during this test case
			},
			{
				rates = [ 5, 10, 30 ],	# An array of rates in Hz
				values = [ 2, 10, 20 ],# An array of number of values
				duration = 5		# The duration of the test case in seconds (depending on the sending rate)
			}
		)
	}
}


paths = (
	{
		# Simple loopback path to test the node
		in = "rtt_node"
		out = "rtt_node"

		# hooks = (
		# 	{
		# 		type = "print"
		# 	}
		# )
	}
)
```
