---
sidebar_position: 1
---

# villas node

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas node` daemon.
The folling usage information is provided when called like `villas node -`:

``` url="generated/node/usage/villas-node.txt" title="villas-node --help"
Usage: villas-node [OPTIONS] [CONFIG]
  OPTIONS is one or more of the following options:
    -h      show this usage information
    -d LVL  set logging level
    -C      show capabilities in JSON format
    -V      show the version of the tool

  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node-types:
 - amqp              Advanced Message Queueing Protoocl (rabbitmq-c)
 - can               Receive CAN messages using the socketCAN driver
 - comedi            Comedi-compatible DAQ/ADC cards
 - ethercat          Send and receive samples of an ethercat connection
 - example           An example for staring new node-type implementations
 - exec              run subprocesses with stdin/stdout communication
 - file              support for file log / replay node type
 - iec61850-9-2      IEC 61850-9-2 (Sampled Values)
 - infiniband        Infiniband interface (libibverbs, librdmacm)
 - influxdb          Write results to InfluxDB
 - kafka             Kafka event message streaming (rdkafka)
 - loopback          loopback node-type
 - mqtt              Message Queuing Telemetry Transport (libmosquitto)
 - nanomsg           scalability protocols library (libnanomsg)
 - ngsi              OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - redis             Redis key-value store
 - rtp               real-time transport protocol (libre, libnl3 netem support)
 - shmem             POSIX shared memory interface with external processes
 - signal            Legacy Signal generator
 - signal.v2         Signal generator
 - socket            BSD network sockets for Ethernet / IP / UDP (libnl3, netem support)
 - stats             Send statistics to another node
 - temper            An temper for staring new node-type implementations
 - test_rtt          Test round-trip time with loopback
 - uldaq             Measurement Computing DAQ devices like UL201 (libuldaq)
 - webrtc            Web Real-time Communication
 - websocket         Send and receive samples of a WebSocket connection (libwebsockets)
 - zeromq            ZeroMQ Distributed Messaging (libzmq)

Supported IO formats:
 - csv               Comma-separated values
 - gtnet             RTDS GTNET
 - iotagent_ul       FIWARE IotAgent UltraLight format
 - json              Javascript Object Notation
 - json.edgeflex     EdgeFlex JSON format
 - json.kafka        JSON Kafka schema/payload messages
 - json.reserve      RESERVE JSON format
 - opal.asyncip      OPAL-RTs AsyncIP example format
 - protobuf          Google Protobuf
 - raw               Raw binary data
 - tsv               Tabulator-separated values
 - value             A bare text value without any headers
 - villas.binary     VILLAS binary network format
 - villas.human      VILLAS human readable format
 - villas.web        VILLAS binary network format for WebSockets

Supported hooks:
 - average           Calculate average over some signals
 - cast              Cast signals types
 - decimate          Downsamping by integer factor
 - dp                Transform to/from dynamic phasor domain
 - drop              Drop messages with reordered sequence numbers
 - dump              Dump data to stdout
 - ebm               Energy-based Metric
 - fix               Fix received data by adding missing fields
 - gate              Skip samples only if an enable signal is under a specified threshold
 - jitter_calc       Calc jitter, mean and variance of GPS vs NTP TS
 - limit_rate        Limit sending rate
 - limit_value       Limit signal values
 - lua               Implement hook functions or expressions in Lua
 - ma                A simple moving average filter over a fixed number of past samples
 - pmu_dft           This hook calculates the  dft on a window
 - pps_ts            Timestamp samples based GPS PPS signal
 - print             Print the message to stdout or a file
 - restart           Call restart hooks for current node
 - rms               This hook calculates the root-mean-square (RMS) on a window
 - scale             Scale signals by a factor and add offset
 - shift_seq         Shift sequence number of samples
 - shift_ts          Shift timestamps of samples
 - skip_first        Skip the first samples
 - stats             Collect statistics for the current node
 - ts                Overwrite origin timestamp of samples with receive timestamp

Supported API commands:
 - capabilities      get capabiltities and details about this VILLASnode instance
 - config            get configuration of this VILLASnode instance
 - graph             get graph representation of configuration
 - node              retrieve info of a node
 - node/file         control instances of 'file' node-type
 - node/pause        pause a node
 - node/restart      restart a node
 - node/resume       resume a node
 - node/start        start a node
 - node/stats        get internal statistics counters
 - node/stats/reset  reset internal statistics counters
 - node/stop         stop a node
 - nodes             retrieve list of all known nodes
 - path              retrieve info of a path
 - path/start        start a path
 - path/stop         stop a path
 - paths             retrieve list of all paths with details
 - restart           restart VILLASnode with new configuration
 - shutdown          quit VILLASnode
 - status            get status and statistics of web server

 v0.11.0-56c966f-debug (built on Mar 14 2022 16:07:12)
 Copyright 2014-2021, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

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
    -C      show capabilities in JSON format
    -V      show the version of the tool

  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node-types:
 - amqp              Advanced Message Queueing Protoocl (rabbitmq-c)
 - can               Receive CAN messages using the socketCAN driver
 - comedi            Comedi-compatible DAQ/ADC cards
 - ethercat          Send and receive samples of an ethercat connection
 - example           An example for staring new node-type implementations
 - exec              run subprocesses with stdin/stdout communication
 - file              support for file log / replay node type
 - iec61850-9-2      IEC 61850-9-2 (Sampled Values)
 - infiniband        Infiniband interface (libibverbs, librdmacm)
 - influxdb          Write results to InfluxDB
 - kafka             Kafka event message streaming (rdkafka)
 - loopback          loopback node-type
 - mqtt              Message Queuing Telemetry Transport (libmosquitto)
 - nanomsg           scalability protocols library (libnanomsg)
 - ngsi              OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - redis             Redis key-value store
 - rtp               real-time transport protocol (libre, libnl3 netem support)
 - shmem             POSIX shared memory interface with external processes
 - signal            Legacy Signal generator
 - signal.v2         Signal generator
 - socket            BSD network sockets for Ethernet / IP / UDP (libnl3, netem support)
 - stats             Send statistics to another node
 - temper            An temper for staring new node-type implementations
 - test_rtt          Test round-trip time with loopback
 - uldaq             Measurement Computing DAQ devices like UL201 (libuldaq)
 - webrtc            Web Real-time Communication
 - websocket         Send and receive samples of a WebSocket connection (libwebsockets)
 - zeromq            ZeroMQ Distributed Messaging (libzmq)

Supported IO formats:
 - csv               Comma-separated values
 - gtnet             RTDS GTNET
 - iotagent_ul       FIWARE IotAgent UltraLight format
 - json              Javascript Object Notation
 - json.edgeflex     EdgeFlex JSON format
 - json.kafka        JSON Kafka schema/payload messages
 - json.reserve      RESERVE JSON format
 - opal.asyncip      OPAL-RTs AsyncIP example format
 - protobuf          Google Protobuf
 - raw               Raw binary data
 - tsv               Tabulator-separated values
 - value             A bare text value without any headers
 - villas.binary     VILLAS binary network format
 - villas.human      VILLAS human readable format
 - villas.web        VILLAS binary network format for WebSockets

Supported hooks:
 - average           Calculate average over some signals
 - cast              Cast signals types
 - decimate          Downsamping by integer factor
 - dp                Transform to/from dynamic phasor domain
 - drop              Drop messages with reordered sequence numbers
 - dump              Dump data to stdout
 - ebm               Energy-based Metric
 - fix               Fix received data by adding missing fields
 - gate              Skip samples only if an enable signal is under a specified threshold
 - jitter_calc       Calc jitter, mean and variance of GPS vs NTP TS
 - limit_rate        Limit sending rate
 - limit_value       Limit signal values
 - lua               Implement hook functions or expressions in Lua
 - ma                A simple moving average filter over a fixed number of past samples
 - pmu_dft           This hook calculates the  dft on a window
 - pps_ts            Timestamp samples based GPS PPS signal
 - print             Print the message to stdout or a file
 - restart           Call restart hooks for current node
 - rms               This hook calculates the root-mean-square (RMS) on a window
 - scale             Scale signals by a factor and add offset
 - shift_seq         Shift sequence number of samples
 - shift_ts          Shift timestamps of samples
 - skip_first        Skip the first samples
 - stats             Collect statistics for the current node
 - ts                Overwrite origin timestamp of samples with receive timestamp

Supported API commands:
 - capabilities      get capabiltities and details about this VILLASnode instance
 - config            get configuration of this VILLASnode instance
 - graph             get graph representation of configuration
 - node              retrieve info of a node
 - node/file         control instances of 'file' node-type
 - node/pause        pause a node
 - node/restart      restart a node
 - node/resume       resume a node
 - node/start        start a node
 - node/stats        get internal statistics counters
 - node/stats/reset  reset internal statistics counters
 - node/stop         stop a node
 - nodes             retrieve list of all known nodes
 - path              retrieve info of a path
 - path/start        start a path
 - path/stop         stop a path
 - paths             retrieve list of all paths with details
 - restart           restart VILLASnode with new configuration
 - shutdown          quit VILLASnode
 - status            get status and statistics of web server

 v0.11.0-56c966f-debug (built on Mar 14 2022 16:07:12)
 Copyright 2014-2021, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```
