# Paths

A path is a **uni-directional** connection between incoming and outgoing nodes.

It forwards messages from one or more incoming nodes to one or more outgoing nodes.
Therefore it represents a n-to-n relation between nodes.

For bidirectional communication a corresponding path in the reverse direction must be added.
 
By default, message contents are not altered.
The server only performs checks for valid message headers (sequence number, cryptographic signature..).
However, every path supports optional [hook functions](../hooks/index.md) which allow user-defined operations on the samples.

<figure align="center">
	<img alt="VILLASnode Paths." src="/img/VILLASnode_paths.svg" width="75%" />
	<figcaption>VILLASnode Paths.</figcaption>
</figure>

The path section in the configuration file consists of a **list** of one or more paths objects.

## Configuration {#config}

Every path object is configured by the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" pointer="#/components/schemas/path" />

## Input mapping

The `paths[].in` setting supports different ways of configuring and selecting the nodes from which the path sources its samples.

### Simple

#### Single node

The easiest way of configuring a path source is by providing a single name of a node.
This will take all signals from this source node and forward it to the path destinations.

<!-- TODO: Convert to json -->
```
paths = (
	{
		in = "udp_node",
		...
	}
)
```

#### Multiple nodes

Instead of a single node also multiple nodes can be provided in a list.
In this configuration all signals from all listed nodes will be concatenated in the order in which the nodes are listed.

<!-- TODO: Convert to json -->
```
paths = (
	{
		in = [
			"udp_node",
			"udp_node2"
		]
		...
	}
)
```

### Complex signal mapping expressions

The last way of configuring signals for a path is by using more complex signal mapping expressions.
This allows you to select individual signals from one or multiple source nodes as well as other metadata such as:

- Statistics
  - **Note:** This requires [`stats`](../hooks/stats.md) hook activated for the respective node)
  - See [here](../hooks/stats.md) for a list of all supported statistics
- Header fields
  - Sample sequence number
  - Sample signal count (length)
  - Timestamps

Se below for a few different examples using the signal mapping expressions

<!-- TODO: Convert to json -->
```
nodes = {
	udp_node = {
		...

		in = {
			signals = (
				{ name = "bus88_V" },
				{ name = "bus102_V" },
				{ name = "bus72_V" },
				{ name = "bus88_I" },
				{ name = "bus102_I" },
				{ name = "bus72_I" },
			),

			hooks = (
				"stats"
			)
		}
	}
}

paths = (
	{
		in = [
			"udp_node.data.bus88_V",
			"udp_node.data.bus102_V",
			"udp_node.bus88_V"
		],
		...
	},
	{
		in = [
			"udp_node.data[0-1]",
			"udp_node.data[bus88_V-bus102_V]"
		],
		...
	},
	{
		in = [
			"udp_node.hdr.sequence",
			"udp_node.hdr.length",
			"udp_node.ts.origin",
			"udp_node.ts.received",
			"udp_node.stats.owd.last",
			"udp_node.stats.skipped.total",
		],
		...
	}
)
```

## Example

<!-- TODO: Convert to json -->
```
paths = (
	{
		in = [
			"rtds.data[0-5]",
			"web.data[0-2]"
		],
		out = [
			"broker",
			"opal"
		],

		reverse = false,
		mode = "any",
		mask = [ "rtds" ],
		rate = 100,
		original_sequence_no = false,

		hooks = (
			{
				type = "print"
			},
			{
				type = "ts"
			}
		)
	}
)
```
