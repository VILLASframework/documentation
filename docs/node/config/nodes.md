---
hide_table_of_contents: true
---

# Nodes

The node section is a map node-names and their configuration which are interfaced by the VILLASnode instance.
The directory is indexed by the name of the node

## Configuration

There are different type of nodes available. But all types share the following common settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/node" />

## Example {#example}

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
			{ name = "Va", unit = "Volts", type = "float", init = 123.456 },
			{ name = "Vb", unit = "Volts", type = "float", init = 123.456 },
			{ name = "Vc", unit = "Volts", type = "float", init = 123.456 },
		)

		# type specific settings follow here.
	}
}
```
