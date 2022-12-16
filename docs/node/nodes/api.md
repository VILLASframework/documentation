---
sidebar_label: REST API
hide_table_of_contents: true
---

# REST API

The `api` node-type allows the exchange of signals via a simple [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) [API](https://en.wikipedia.org/wiki/Web_API).

The provided REST API aims at implementing the [Universal Data-exchange API](https://erigrid2.github.io/JRA-3.1-api/universal-api.html) drafted by the [ERIGrid 2.0 project](https://erigrid2.eu).

## Compatability

VILLASnode implements currently version v2 of the Universal Data-exchange API.

### Limitations

- VILLASnode does not support the data-type `string`
- VILLASnode does not support the payload-type `events`.
- VILLASnode implements the API server side only.
	- VILLASnode might be extended in the future to act in the client role as well.
	- This would enable its use as the _last-mile_ or _RI-adapter_.

### Terminology

There are some slight differences in the terminology as used in the VILLASframework and universal API.
The following table lists terms which are used synonymously:

| VILLAS | Universal API |
|:--     |:--            |
| signal | channel       |

## Prerequisites

This node-type requires VILLASweb to be compiled with web-support enabled (`cmake -DWITH_WEB`).
This is the default if the `libwebsockets` library has been detected on the system.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/api.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/api" />

## Example

``` url="external/node/etc/examples/nodes/api.conf" title="node/etc/examples/nodes/api.conf"
nodes = {
	api_node = {
		type = "api"

		in = {
			signals = (
				{
					name = "" 			# Same as 'id' in uAPI context
					description = "Volts on Bus A"	# A human readable description of the channel
					type = "float"			# Same as 'datatype' in uAPI context
					unit = "V"
					payload = "events" 		# or 'samples'
					rate = 100.0			# An expected refresh/sample rate of the signal
					range = {
						min = 20.0
						max = 100.0
					}
					readable = true
					writable = false
				}
			)
		}

		out = {
			signals = (
				# Similar to above
			)
		}
	}
}
```

### Full config

``` url="external/node/etc/examples/api.conf" title="node/etc/examples/api.conf"
http = {
	port = 8080
}

nodes = {
	api_node = {
		type = "api"

		in = {
			signals = (
				{
					name = "sig1_in",
					type = "float",
					unit = "V",
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				},
				{
					name = "sig2_in",
					type = "float",
					unit = "A",
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				},
				{
					name = "sig3_in",
					type = "float",
					unit = "A",
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				}
			)
		}

		out = {
			signals = (
				# Output signals have no name, type and unit settings as those are implicitly
				# derived from the signals which are routed to this node
				{
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				},
				{
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				},
				{
					description = "Signal 1",
					rate = 100,
					readable = true,
					writable = false,
					payload = "samples"
				}
			)
		}
	}

	signal_node = {
		type = "signal"

		signal = "mixed"
		values = 5
		rate = 1.0
	}
}

paths = (
	{
		in = [
			"api_node"
		],
		hooks = (
			"print"
		)
	},
	{
		in = [
			"signal_node"
		]
		out = [
			"api_node"
		]
		hooks = (
			"print"
		)
	}
)
```

## Usage

The following [`curl`](https://curl.se/) commands demonstrate the usage of the REST API node-type.
For a full reference of the API, please have a look at the official API spec [at the ERIGrid API repository](https://erigrid2.github.io/JRA-3.1-api/universal-api.html).

:::note
Please make sure to substitute `api_node` with the actual name or UUID of your node.
:::

#### Get list of channels provided by the node

```bash
curl -v http://localhost:80/api/v2/universal/api_node/channels
```

#### Get current value of a signal by its ID

```bash
curl -v http://localhost:80/api/v2/universal/api_node/channel/ramp/sample
```

#### Update signal value by its ID

```bash
curl -v -XPUT -d '{"timestamp": 1648482084.1462665,"value":1234.0}' http://localhost:80/api/v2/universal/api_node/channel/signal0/sample
```
