---
sidebar_label: REST API
hide_table_of_contents: true
---

# REST API

The `api` node-type allows the exchange of signals via a simple [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) [API](https://en.wikipedia.org/wiki/Web_API).

The provided REST API aims at implementing the [Universal Data-exchange API]([at the ERIGrid API repository](https://erigrid2.github.io/JRA-3.1-api/universal-api.html)) drafted by the [ERIGrid 2.0 project](https://erigrid2.eu).

## Prerequisites

This node-type requires VILLASweb to be compiled with web-support enabled (`cmake -DWITH_WEB`).
This is the default if the `libwebsockets` library has been detected on the system.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/api.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/api" />

## Example

``` url="external/node/etc/examples/nodes/api.conf" title="node/etc/examples/nodes/api.conf"
nodes = {
	api_node = {
		type = "api"

		// Additional configuration can be retrieved via Rest API call:
		//     curl http://localhost:80/api/v2/universal/api_node/config
		my_setting = "my_value"
		a = {
			b = false
		}
	}
}
```

## Usage

The following [`curl`](https://curl.se/) commands demonstrate the usage of the REST API node-type.
For a full reference of the API, please have a look at the official API spec [at the ERIGrid API repository](https://erigrid2.github.io/JRA-3.1-api/universal-api.html).

:::note
Please make sure to substitute `api_node` with the actual name or UUID of your node.
:::

#### Get node configuration

```bash
curl -v localhost:80/api/v2/universal/api_node/config
```

#### Get list of signals provided by the node

```bash
curl -v localhost:80/api/v2/universal/api_node/signals
```

#### Get current value of a signal by its ID

```bash
curl -v localhost:80/api/v2/universal/api_node/signal/ramp/state
```

#### Update signal value by its ID

```bash
curl -v -XPUT -d '{"timestamp": 1648482084.1462665,"value":1234}' localhost:80/api/v2/universal/api_node/signal/signal0/state
```
