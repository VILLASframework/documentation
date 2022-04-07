---
hide_table_of_contents: true
---

# InfluxDB

The `influxdb` node-type streams simulation data in real-time to a [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/) time-series database using an [UDP service](https://docs.influxdata.com/influxdb/v0.9/write_protocols/udp/) and a plain text [line protocol](https://docs.influxdata.com/influxdb/v1.7/write_protocols/line_protocol_reference/).

Each signal of a sample is mapped to one field. VILLASnode maps the signal names of the data source to InfluxDB fields.

See also: [InfluxDB documentation](https://docs.influxdata.com/influxdb/v0.9/write_protocols/line/#fields)

## Prerequisites

This node-type does not have any special library dependencies.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/influxdb.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/influxdb" />

## Example

``` url="external/node/etc/examples/nodes/influxdb.conf" title="node/etc/examples/nodes/influxdb.conf"
nodes = {
	influxdb_node = {
		type = "influxdb",

		server = "localhost:8089",
		key = "villas"
	}
}
```
