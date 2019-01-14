# InfluxDB {#node-type-influxdb}

The @ref node-type-influxdb node-type streams simulation data in real-time to a [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/) time-series database using an [UDP service](https://docs.influxdata.com/influxdb/v0.9/write_protocols/udp/) and a plain text [line protocol]().

# Prerequisites {#node-prereq-influxdb}

This node-type does not have any special library dependencies.

# Implementation {#node-implementation-influxdb}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/influxdb.c

# Configuration {#node-config-influxdb}

## server (string) {#node-config-influxdb-server}

A hostname/port combination of the InfluxDB database server.

## key (string) {#node-config-influxdb-key}

The key is the measurement name and any optional tags separated by commas.

See also: [InfluxDB documentation](https://docs.influxdata.com/influxdb/v0.9/write_protocols/line/#key)

## fields (array of strings) {#node-config-influxdb-fields}

Each signal of a sample is mapped to one field.
This array of strings is used to map the signal indices to field names.

See also: [InfluxDB documentation](https://docs.influxdata.com/influxdb/v0.9/write_protocols/line/#fields)

## Example

```
nodes = {
	influxdb_node = {
		type = "influxdb",

		server = "localhost:8089",
		key = "villas",
		fields = [
			"a", "b", "c"
		]
	}
}
```
