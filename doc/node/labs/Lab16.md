# Lab 16: Visualize simulation data with InfluxDB and Grafana

This lab session demonstrates the visualization of historic simulation data via the web-based Grafana dashboard.
For this purpose, VILLASnode persists the simulation data into the InfluxDB time-series database via a dedicated @ref node-type-influxdb node-type.

This node-type streams the simulation data via UDP to an InfluxDB database using the line protocol.

## Further information

- https://docs.influxdata.com/influxdb/v1.7/supported_protocols/udp/
- https://docs.influxdata.com/influxdb/v1.7/write_protocols/line_protocol_tutorial/

## Prerequisites

Up-to-date versions of:

- VILLASnode
- Docker
- docker-compose

## 1. Prepare Grafana and InfluxDB

We first need to prepare a standard Grafana and InfluxDB setup.
For this task we use Docker containers and the following `docker-compose.yml` file.

### `docker-compose.yml`

```yml
influxdb:
  image: influxdb:1.7.10
  container_name: influxdb
  ports:
    - "8083:8083"
    - "8086:8086"
    - "8090:8090"
    - "8089:8089/udp"
  environment:
    - INFLUXDB_DATA_ENGINE=tsm1
    - INFLUXDB_REPORTING_DISABLED=false
    - INFLUXDB_DB=villas
    - INFLUXDB_ADMIN_USER=admin
    - INFLUXDB_ADMIN_PASSWORD=admin
    - INFLUXDB_UDP_ENABLED=true
    - INFLUXDB_UDP_DATABASE=villas

grafana:
  image: grafana/grafana:6.6.2
  container_name: grafana
  ports:
    - "3000:3000"
  environment:
    - GF_SECURITY_ADMIN_USER=admin
    - GF_SECURITY_ADMIN_PASSWORD=admin
  links:
    - influxdb
```

### Steps

1. Copy the contents of the `docker-compose.yml` file to a new file on your system.
2. Bring-up Grafana and InfluxDB with: `docker-compose up -d` from the same directory
3. Open the Grafana web-interface at: http://localhost:3000/
4. Login with the credentials:
   - **User:**
   - **Admin:**
5. Follow the setup wizard of Grafana and add a new data source with the following parameters
  - **Type:** InfluxDB
  - **Name:** villas
  - **URL:** http://influxdb:8086
  - **Database:** villas
  - **User:** admin
  - **Admin:** admin

## 2. Import Demo Dashboard into Grafana

## 3. Run dummy simulation to fill InfluxDB with test data

### influxdb.conf

@include node/etc/examples/nodes/influxdb.conf

### Steps

1. Add the following lines to a new file name `influxdb.conf`.
2. Run to following command to generate test data which VILLAsnode will store in the InfluxDB database: `villas-signal mixed -v6 -r 50 | villas-pipe -s influxdb.conf influxdb_node`
3. Return to Grafana to inspect the data

### Screenshot

@image html grafana.png Grafana Dashboard width=100%
