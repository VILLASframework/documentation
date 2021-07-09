# Paths {#node-config-paths}

The path section consists of a **list** of paths:

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

Every path can have the following settings:

## in (list of strings: node-names | mapping expression) {#node-config-path-in}

The `in` settings expects the name of one or more source nodes or mapping expressions.

See @ref node-config-path-mapping

## out (list of strings: node-names) {#node-config-path-out}

The `out` setting expects the name of one or more destination nodes.
Each sample which is processed by the path will be sent to each of the destination nodes.

## enabled (boolean) {#node-config-path-enabled}

The optional `enabled` setting can be used to temporarily disable a path.
If omitted, the path is enabled by default.

## reverse (boolean) = false {#node-config-path-reverse}

By default, the path is unidirectional. Meaning, that it only forwards samples from the source to the destination.
Sometimes a bidirectional path is needed.
This can be accomplished by setting `reverse` to `true`.

## mode (string: "all" | "any") = "any" {#node-config-path-mode}

The mode setting specifies under which condition a path is _triggered_.
A triggered path will multiplex / merge samples from its input nodes and run the configured hook functions on them.
Afterwards the processed and merged samples will be send to all output nodes.

Two modes are currently supported:

- `any`: The path will trigger the path as soon as any of the masked (see @ref node-config-path-mask) input nodes received new samples.
- `all`: The path will trigger the path as soon as all input nodes received at least one new sample.

## mask (list of strings: node-names) = _all input nodes_ {#node-config-path-mask}

This setting allows masking the the input nodes which can trigger the path.

See also: @ref node-config-path-mode

## rate (float) = 0 {#node-config-path-rate}

A non-zero value will periodically trigger the path and resend the last sample again.

A value of zero will disable this feature.

## original_sequence_no (boolean) = false {#node-config-path-original_sequence_no}

When this flag is set, the original sequence number from the source node will be used when multiplexing the nodes.

## hooks (list of objects: hooks) {#node-config-path-hooks}

A list of hook functions which will be executed for each sample which is processed by this path.

Please consult the @ref node-concept-hook chapter of this documentation for details.

### hooks[].type (string: "print" | "drop" | ...) {#node-config-hooks-type}

### hooks[].enabled (boolean) = true {#node-config-hooks-enabled}

# Input mapping {#node-config-path-mapping}

The @ref node-config-path-in setting supports different ways of configuring and selecting the nodes from which the path sources its samples.

## Simple

### Single node

The easiest way of configuring a path source is by providing a single name of a node.
This will take all signals from this source node and forward it to the path destinations.

```
paths = (
	{
		in = "udp_node",
		...
	}
)
```

### Multiple nodes

Instead of a single node also multiple nodes can be provided in a list.
In this configuration all signals from all listed nodes will be concatenated in the order in which the nodes are listed.

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

## Complex signal mapping expressions

The last way of configuring signals for a path is by using more complex signal mapping expressions.
This allows you to select individual signals from one or multiple source nodes as well as other metadata such as:

- Statistics
  - **Note:** This requires @ref hook-type-stats hook activated for the respective node)
  - See @ref hook-type-stats for a list of all supported statistics
- Header fields
  - Sample sequence number
  - Sample signal count (length)
  - Timestamps

Se below for a few different examples using the signal mapping expressions

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
