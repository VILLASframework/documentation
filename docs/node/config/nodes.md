# Nodes {#node-config-nodes}

The node section is a **directory** of nodes (clients) which are connected to the VILLASnode instance.
The directory is indexed by the name of the node

# Example {#node-config-nodes-example}

<!-- TODO: Convert to json -->
```
nodes = {
	"sintef_node" = {
		type = "socket",
		vectorize = 10,
		hooks = (
			{
				type = "decimate",
				ratio = 10
			}
		),

		builtin = true,
		samplelen = 64,

		signals = (
			{ name = "Va", unit = "Volts", type = "float", "init": 230.0 },
			{ name = "Vb", unit = "Volts", type = "float", "init": 230.0 },
			{ name = "Vc", unit = "Volts", type = "float", "init": 230.0 },
		)

		# type specific settings follow here.
	}
}
```

# Configuration {#node-config-node}

There are different type of nodes available. But all types have the following settings in common:

## type (string: "socket" | "fpga" | ...) {#node-config-node-type}

`type` specifies which interface should be used for this node.

For a complete list of supported node-types run `villas node --help`.

In addition to the node settings described in this section, every node type has its own specific settings.
Take a look at the @ref node-node-types page for details.

## out.netem (directory) {#node-config-node-netem}

Some socket based node-types support network emulation.

For more details see @ref node-netem . Please note that not all node-types support network emulation.

## in.vectorize (integer) = 1 {#node-config-node-vectorize}

This setting allows to send multiple samples in a single message to the destination nodes.

The value of this setting determines how many samples will be combined into one packet.

## in.hooks (list of objects: hooks) {#node-config-node-hook}

A list of hook functions which will be executed for each sample which is processed by this path.

See @ref node-hook-types chapter of this documentation for details.

## builtin (boolean) = true {#node-config-node-builtin}

By default, each node and paths has a couple of default hooks attached to them.
With this setting the attachment of built-in hooks can be disabled.

## in.signals (list of objects: signals) = "64f" {#node-config-node-signals}

Each node should define a list of signals which it **receives**.

There are three ways to specify the input signals of a node:

### List (recommended)  {#node-config-node-signals-list}

The list mode allows you to specify properties of each signal individually by providing a list of signal definitions:

<!-- TODO: Convert to json -->
```
nodes = {
	test_node = {
		in = {
			signals = (
				{ name = "signal1", type = "float" },
				{ name = "signal2", type = "integer" }
			)
		}
	}
}
```

Each signal is described by the following settings:

#### in.signals[].name (string) = "signal_#" {#node-config-node-signals-name}

A name which describes the signal.

#### in.signals[].unit (string) = undefined {#node-config-node-signals-unit}

The unit of the signal. E.g. `V`, `A`, `Rad`.

#### in.signals[].type (string: "float" | "integer" | "boolean" | "complex" | "auto") = auto {#node-config-node-signals-type}

The data-type of the signal.

#### in.signals[].init (float | integer | boolean | complex) {#node-config-node-signals-init}

The initial value of the signal.

### Format string  {#node-config-node-signals-fstring}

The easiest way to specify the signals, is by using a format string.
The format string consists of one ore more characters which define the type for the signal corresponding to the position of the character in the string.

| Character | Type            | Setting for full and list mode |
|:---       |:---             |:---
| `f`       | Floating point | "float" |
| `b`       | Boolean | "boolean" |
| `i`       | Integer | "integer" |
| `c`       | Complex Floating point | "complex" |

Optionally, the characters can be prefixed by an integer for easier repitition.

The following signal definition defines 15 signals, of which the first 12 are floating point and the last 3 are integer values.

<!-- TODO: Convert to json -->
```
nodes = {
	test_node = {
		in = {
			signals = "12f3i"
		}
	}
}
```

### Simple  {#node-config-node-signals-simple}

The simple way just specifies the number of signals and their type:

<!-- TODO: Convert to json -->
```
nodes = {
	test_node = {
		in = {
			signals = {
				count = 12
				type = "float"
			}
		}
	}
}
```
