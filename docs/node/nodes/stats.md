# Statistics {#node-type-stats}

The "stats" node-type receives statistics of a node or path.

# Prerequisites {#node-type-stats-prereq}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-type-stats-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/stats.cpp

# Configuration {#node-config-node-stats}

@todo Document config settings of statistics node-type

# Example {#node-type-stats-example}

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
