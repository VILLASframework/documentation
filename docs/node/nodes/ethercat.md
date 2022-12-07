---
hide_table_of_contents: true
---

# EtherCAT

:::danger
This node-type is currently under development.
:::

## Prerequisites

This node-type requires the [IgH EtherCAT Master](http://etherlab.org) (>= 1.5.2).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/ethercat.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/ethercat" />

## Example

``` url="external/node/etc/examples/nodes/ethercat.conf" title="node/etc/examples/nodes/ethercat.conf"
ethercat = {
	coupler = {
		position = 0
		vendor_id = 0x00000002    # Backhoff
		product_code = 0x044c2c52 # EK1100
	}

	alias = 0
	master = 0
}

nodes = {
	ethercat_node = {
		type = "ethercat"

		rate = 1000.0 # Rate of master cyclic task

		# Analog Input Slave
		in = {
			num_channels = 8
			range = 10.0 # -10.0 V to +10.0 V

			position = 2
			vendor_id = 0x00000002    # Beckhoff
			product_code = 0x0bc03052 # EL3008

			# PDOs are currently hardcoded!
		}

		# Analog Output Slave
		out = {
			num_channels = 8
			range = 10.0 # -10.0 V to +10.0 V

			position = 1
			vendor_id = 0x00000002    # Beckhoff
			product_code = 0x0fc63052 # EL4038

			# PDOs are currently hardcoded!
		}
	}
}
```
