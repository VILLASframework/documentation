---
hide_table_of_contents: true
---

# Statistics

The "stats" node-type receives statistics of a node or path.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/stats.cpp

## Configuration {#config}

:::note ToDo

Document config settings of statistics node-type

:::

## Example

``` url="external/node/etc/examples/nodes/stats.conf" title="node/etc/examples/nodes/stats.conf"
nodes = {
	udp_node = {
		type = "socket"

		in = {
			address = "*:12000"
		}
		out = {
			address = "127.0.0.1:12000"
		}
	}
	stats_node = {
		type = "stats"
			
		node = "udp_node"
		rate = 2

		in = {
			signals = (
				{ name = "one_way_delay_mean", type = "float", stats = "udp_node.owd.mean" },
				{ name = "one_way_delay_min",  type = "float", stats = "udp_node.owd.lowest" },
				{ name = "one_way_delay_max",  type = "float", stats = "udp_node.owd.highest" }
			)
		}
	}
}
```
