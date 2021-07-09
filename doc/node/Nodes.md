# Node-types {#node-node-types}

All communication partners which are interfaced by the VILLASnode gateway are represented by nodes.
These nodes act as sinks / sources for simulation data.
Every node is an instance of a node-type. In a single VILLASnode instance, multiples instances of the same node-type can be created at the same time.

VILLASnode currently supports the following node-types:

| Type                            | Network Emulation | Read | Write | Vectorize | Status      | Comments |
| :--                             | :--               | :--  | :--   | :--       | :--         | :--      |
| @subpage node-type-amqp         | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-can          | no                | yes  | yes   | ?         | beta        | |
| @subpage node-type-comedi       | no                | yes  | yes   | unlimited | beta        | Support for a wide range of Analog/Digital Input/Output cards |
| @subpage node-type-ethercat     | no                | yes  | yes   | ?         | alpha       | |
| @subpage node-type-exec         | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-file         | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-fpga         | no                | yes  | yes   | ?         | beta        | |
| @subpage node-type-iec61850-8-1 | no                | yes  | yes   | 1         | alpha       | |
| @subpage node-type-iec61850-9-2 | no                | yes  | yes   | 1         | beta        | |
| @subpage node-type-infiniband   | no                | yes  | yes   | unlimited | beta        | |
| @subpage node-type-influxdb     | no                | no   | yes   | unlimited | stable      | |
| @subpage node-type-kafka        | yes               | yes  | yes   | unlimited | stable      | |
| @subpage node-type-loopback     | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-mqtt         | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-nanomsg      | yes               | yes  | yes   | unlimited | stable      | |
| @subpage node-type-ngsi         | no                | yes  | yes   | unlimited | stable      | Use WebSockets for Live data |
| @subpage node-type-opal         | no                | yes  | yes   | 1         | untested    | |
| @subpage node-type-redis        | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-rtp          | yes               | yes  | yes   | ?         | beta        | |
| @subpage node-type-shmem        | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-signal       | no                | yes  | no    | 1         | stable      | |
| @subpage node-type-socket       | yes               | yes  | yes   | unlimited | stable      | |
| @subpage node-type-stats        | no                | yes  | no    | 1         | stable      | |
| @subpage node-type-temper       | no                | yes  | no    | unlimited | stable      | |
| @subpage node-type-test-rtt     | no                | yes  | yes   | unlimited | stable      | Virtual node-type |
| @subpage node-type-uldaq        | no                | yes  | no    | unlimited | stable      | |
| @subpage node-type-websocket    | no                | yes  | yes   | unlimited | stable      | |
| @subpage node-type-zeromq       | yes               | yes  | yes   | unlimited | stable      | |

@image html VILLASnode_interfaces.svg width=100%
