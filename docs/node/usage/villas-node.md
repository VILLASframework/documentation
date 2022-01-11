# villas node {#node-usage-node}

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas node` daemon.
The folling usage information is provided when called like `villas node -`:

``` url="generated/node/usage/villas-node.txt" title="generated/node/usage/villas-node.txt"
Usage: villas-node [OPTIONS] [CONFIG]
  OPTIONS is one or more of the following options:
    -h      show this usage information
    -d LVL  set logging level
    -V      show the version of the tool

  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node-types:
 - loopback_internal: internal loopback to connect multiple paths
 - influxdb     : Write results to InfluxDB
 - stats        : Send statistics to another node
 - signal       : Signal generator
 - loopback     : Loopback to connect multiple paths
 - test_rtt     : Test round-trip time with loopback
 - socket       : BSD network sockets for Ethernet / IP / UDP (libnl3, netem support)
 - file         : support for file log / replay node type
 - exec         : run subprocesses with stdin/stdout communication
 - shmem        : POSIX shared memory interface with external processes
 - zeromq       : ZeroMQ Distributed Messaging (libzmq)
 - ngsi         : OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - websocket    : Send and receive samples of a WebSocket connection (libwebsockets)
 - amqp         : Advanced Message Queueing Protoocl (rabbitmq-c)
 - mqtt         : Message Queuing Telemetry Transport (libmosquitto)
 - can          : Receive CAN messages using the socketCAN driver
 - example      : An example for staring new node-type implementations
 - ethercat     : Send and receive samples of an ethercat connection

Supported IO formats:
 - json         : Javascript Object Notation
 - iotagent_ul  : FIWARE IotAgent UltraLight format
 - json.reserve : RESERVE JSON format
 - villas.binary: VILLAS binary network format
 - villas.web   : VILLAS binary network format for WebSockets
 - villas.human : VILLAS human readable format
 - tsv          : Tabulator-separated values
 - csv          : Comma-separated values
 - raw.8        : Raw  8 bit
 - raw.16.be    : Raw 16 bit, big endian byte-order
 - raw.32.be    : Raw 32 bit, big endian byte-order
 - raw.64.be    : Raw 64 bit, big endian byte-order
 - raw.16.le    : Raw 16 bit, little endian byte-order
 - raw.32.le    : Raw 32 bit, little endian byte-order
 - raw.64.le    : Raw 64 bit, little endian byte-order
 - gtnet        : RTDS GTNET
 - gtnet.fake   : RTDS GTNET with fake header
 - value        : A bare text value without any headers

Supported hooks:
 - average: Calculate average over some signals
 - cast: Cast signals types
 - decimate: Downsamping by integer factor
 - dft: This hook calculates the  dft on a window
 - dp: Transform to/from dynamic phasor domain
 - drop: Drop messages with reordered sequence numbers
 - dump: Dump data to stdout
 - ebm: Energy-based Metric
 - fix: Fix received data by adding missing fields
 - gate: Skip samples only if an enable signal is under a specified threshold
 - jitter_calc: Calc jitter, mean and variance of GPS vs NTP TS
 - limit_rate: Limit sending rate
 - average: Calculate average over some signals
 - restart: Call restart hooks for current node
 - scale: Scale signals by a factor and add offset
 - shift_seq: Shift sequence number of samples
 - shift_ts: Shift timestamps of samples
 - skip_first: Skip the first samples
 - stats: Collect statistics for the current path
 - ts: Overwrite origin timestamp of samples with receive timestamp
 - pps_ts: Timestamp samples based GPS PPS signal
 - print: Print the message to stdout
 - lua: Implement hook in Lua

Supported API commands:
 - status: get status and statistics of web server
 - capabilities: get capabiltities and details about this VILLASnode instance
 - config: get configuration of this VILLASnode instance
 - shutdown: quit VILLASnode
 - restart: restart VILLASnode with new configuration
 - nodes: retrieve list of all known nodes
 - node: retrieve info of a node
 - node/start: start a node
 - node/stop: stop a node
 - node/pause: pause a node
 - node/resume: resume a node
 - node/restart: restart a node
 - node/stats: get internal statistics counters
 - node/stats/reset: reset internal statistics counters
 - node/file: control instances of 'file' node-type
 - paths: retrieve list of all paths with details
 - path: retrieve info of a path
 - path/start: start a path
 - path/stop: stop a path
 - graph: get graph representation of configuration

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>```

The server requires root privileges to:

 - Enable the realtime FIFO scheduler
 - Increase the task priority
 - Configure the [network emulator](../netem.md)
 - Change the SMP affinity of threads and network interrupts

# Usage

``` url="generated/node/usage/villas-node.txt" title="generated/node/usage/villas-node.txt"
Usage: villas-node [OPTIONS] [CONFIG]
  OPTIONS is one or more of the following options:
    -h      show this usage information
    -d LVL  set logging level
    -V      show the version of the tool

  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node-types:
 - loopback_internal: internal loopback to connect multiple paths
 - influxdb     : Write results to InfluxDB
 - stats        : Send statistics to another node
 - signal       : Signal generator
 - loopback     : Loopback to connect multiple paths
 - test_rtt     : Test round-trip time with loopback
 - socket       : BSD network sockets for Ethernet / IP / UDP (libnl3, netem support)
 - file         : support for file log / replay node type
 - exec         : run subprocesses with stdin/stdout communication
 - shmem        : POSIX shared memory interface with external processes
 - zeromq       : ZeroMQ Distributed Messaging (libzmq)
 - ngsi         : OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - websocket    : Send and receive samples of a WebSocket connection (libwebsockets)
 - amqp         : Advanced Message Queueing Protoocl (rabbitmq-c)
 - mqtt         : Message Queuing Telemetry Transport (libmosquitto)
 - can          : Receive CAN messages using the socketCAN driver
 - example      : An example for staring new node-type implementations
 - ethercat     : Send and receive samples of an ethercat connection

Supported IO formats:
 - json         : Javascript Object Notation
 - iotagent_ul  : FIWARE IotAgent UltraLight format
 - json.reserve : RESERVE JSON format
 - villas.binary: VILLAS binary network format
 - villas.web   : VILLAS binary network format for WebSockets
 - villas.human : VILLAS human readable format
 - tsv          : Tabulator-separated values
 - csv          : Comma-separated values
 - raw.8        : Raw  8 bit
 - raw.16.be    : Raw 16 bit, big endian byte-order
 - raw.32.be    : Raw 32 bit, big endian byte-order
 - raw.64.be    : Raw 64 bit, big endian byte-order
 - raw.16.le    : Raw 16 bit, little endian byte-order
 - raw.32.le    : Raw 32 bit, little endian byte-order
 - raw.64.le    : Raw 64 bit, little endian byte-order
 - gtnet        : RTDS GTNET
 - gtnet.fake   : RTDS GTNET with fake header
 - value        : A bare text value without any headers

Supported hooks:
 - average: Calculate average over some signals
 - cast: Cast signals types
 - decimate: Downsamping by integer factor
 - dft: This hook calculates the  dft on a window
 - dp: Transform to/from dynamic phasor domain
 - drop: Drop messages with reordered sequence numbers
 - dump: Dump data to stdout
 - ebm: Energy-based Metric
 - fix: Fix received data by adding missing fields
 - gate: Skip samples only if an enable signal is under a specified threshold
 - jitter_calc: Calc jitter, mean and variance of GPS vs NTP TS
 - limit_rate: Limit sending rate
 - average: Calculate average over some signals
 - restart: Call restart hooks for current node
 - scale: Scale signals by a factor and add offset
 - shift_seq: Shift sequence number of samples
 - shift_ts: Shift timestamps of samples
 - skip_first: Skip the first samples
 - stats: Collect statistics for the current path
 - ts: Overwrite origin timestamp of samples with receive timestamp
 - pps_ts: Timestamp samples based GPS PPS signal
 - print: Print the message to stdout
 - lua: Implement hook in Lua

Supported API commands:
 - status: get status and statistics of web server
 - capabilities: get capabiltities and details about this VILLASnode instance
 - config: get configuration of this VILLASnode instance
 - shutdown: quit VILLASnode
 - restart: restart VILLASnode with new configuration
 - nodes: retrieve list of all known nodes
 - node: retrieve info of a node
 - node/start: start a node
 - node/stop: stop a node
 - node/pause: pause a node
 - node/resume: resume a node
 - node/restart: restart a node
 - node/stats: get internal statistics counters
 - node/stats/reset: reset internal statistics counters
 - node/file: control instances of 'file' node-type
 - paths: retrieve list of all paths with details
 - path: retrieve info of a path
 - path/start: start a path
 - path/stop: stop a path
 - graph: get graph representation of configuration

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>```
