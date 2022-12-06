---
sidebar_label: FIWARE NGSI
---

# Open Mobile Alliance (OMA) - Next Generation Services Interface (NGSI)

The `ngsi` node type implements an interface to FIWARE context brokers.
Currently version 1 of the RESTful HTTP API is implemented and using NGSI10 for the context management interface.

This implementation if currently limited to the `updateContext` operation.
Therefore only publishing updates is supported. Subscription or polling of events is planned for later versions.

## Prerequisites

This node-type requires to following libraries to communicate with the context broker over JSON:

- [libjansson](http://www.digip.org/jansson/) (>= 2.7)
- [libcurl](https://curl.haxx.se/libcurl/) (>= 7.29.0)

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/ngsi.cpp

## Configuration {#config}

You can use the [`vectorize` setting](../config/nodes.md#vectorize) to send multiple samples in a vector.

Every `ngsi` node supports the following special settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/ngsi" />

## Example

``` url="external/node/etc/examples/nodes/ngsi.conf" title="node/etc/examples/nodes/ngsi.conf"
nodes = {
	ngsi_node = {
		type = "ngsi",

	### The following settings are specific to the ngsi node-type!! ###

		# The HTTP REST API endpoint of the FIRWARE context broker
		endpoint = "http://46.101.131.212:1026",

		access_token: "aig1aaQuohsh5pee9uiC2Bae3loSh9wu"	# Add an 'Auth-Token' token header to each request

		entity_id = "S3_ElectricalGrid",
		entity_type = "ElectricalGridMonitoring",

		create = true				# Create the NGSI entities during startup

		rate = 0.1					# Rate at which we poll the broker for updates
		timeout = 1,				# Timeout of HTTP request in seconds (default is 1, must be smaller than 1 / rate)
		verify_ssl = false,			# Verification of SSL server certificates (default is true)

		in = {
			signals = (
				{
					name = "attr1",
					ngsi_attribute_name = "attr1",	# defaults to signal 'name'
					ngsi_attribute_type = "Volts",	# default to signal 'unit'
					ngsi_attribute_metadatas = (
						{ name="accuracy", type="percent", value="5" }
					)
				}
			)
		}

		out = {
			signals = (
				{ name="PTotalLosses", unit="MW" },
				{ name="QTotalLosses", unit="Mvar" }
			)
		}
	}
}
```

## Further reading

This standard was specified by the Open Mobile Alliance (OMA).

- [FIWARE-NGSI v2 Specification](http://fiware.github.io/specifications/ngsiv2/stable/)
- [Open Mobile Alliance - NGSI Context Management](http://www.openmobilealliance.org/release/ngsi/v1_0-20120529-a/oma-ts-ngsi_context_management-v1_0-20120529-a.pdf)
