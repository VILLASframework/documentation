---
sidebar_label: CAN
hide_table_of_contents: true
---

# Controller Area Network (CAN)

The `can` node-type allows the exchange of signals via a [CAN bus](https://www.can-cia.org/can-knowledge/).

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/can.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/can" />

## Example

``` url="external/node/etc/examples/nodes/can.conf" title="node/etc/examples/nodes/can.conf"
nodes = {
	can_node1 = {
		type = "can"
		interface_name = "vcan0"
		sample_rate = 500000

		in = {
			signals = (
				{
					name = "sigin1",
					unit = "Volts",
					type = "float",
					enabled = true,
					can_id = 66, 
					can_size = 4,
					can_offset = 0
				},
				{
					name = "sigin2",
					unit = "Volts",
					type = "float",
					enabled = true,
					can_id = 66, 
					can_size = 4,
					can_offset = 4
				},
				{
					name = "sigin3",
					unit = "Volts",
					type = "float",
					enabled = true,
					can_id = 67, 
					can_size = 8,
					can_offset = 0
				}
			)
		}

		out = {
			signals = (
				{
					type = "float",
					can_id = 66, 
					can_size = 4,
					can_offset = 0
				},
				{
					type = "float",
					can_id = 66, 
					can_size = 4,
					can_offset = 4
				},
				{
					type = "float",
					can_id = 67, 
					can_size = 8,
					can_offset = 0
				}
			)
		}
	}
}
```
