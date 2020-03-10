# InfluxDB {#node-type-influxdb}

The @ref node-type-influxdb node-type streams simulation data in real-time to a [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/) time-series database using an [UDP service](https://docs.influxdata.com/influxdb/v0.9/write_protocols/udp/) and a plain text [line protocol](https://docs.influxdata.com/influxdb/v1.7/write_protocols/line_protocol_reference/).

Each signal of a sample is mapped to one field. VILLASnode maps the signal names of the data source to InfluxDB fields.

See also: [InfluxDB documentation](https://docs.influxdata.com/influxdb/v0.9/write_protocols/line/#fields)

# Prerequisites {#node-prereq-influxdb}

This node-type does not have any special library dependencies.

# Implementation {#node-implementation-influxdb}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/influxdb.c

# Configuration {#node-config-node-influxdb}

## server (string) {#node-config-node-influxdb-server}

A hostname/port combination of the InfluxDB database server.

## key (string) {#node-config-node-influxdb-key}

The key is the measurement name and any optional tags separated by commas.

See also: [InfluxDB documentation](https://docs.influxdata.com/influxdb/v0.9/write_protocols/line/#key)

## Example

@include node/etc/examples/nodes/influxdb.conf
