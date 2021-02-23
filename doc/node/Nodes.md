# Node-types {#node-types}

All communication partners which are interfaced by the VILLASnode gateway are represented by nodes.
These nodes act as sinks / sources for simulation data.
Every node is an instance of a node-type. In a single VILLASnode instance, multiples instances of the same node-type can be created at the same time.

VILLASnode currently supports the following node-types:

| Type                            | Network Emulation | Sync  | Read | Write | Vectorize | Status      | Comments |
| :--                             | :--               | :--   | :--  | :--   | :--       | :--         | :--      |
| @subpage node-type-amqp         | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-can          | no                | AIO   | yes  | yes   | ?         | beta        | |
| @subpage node-type-comedi       | no                | Poll  | yes  | yes   | unlimited | beta        | Support for a wide range of Analog/Digital Input/Output cards |
| @subpage node-type-ethercat     | no                | Poll  | yes  | yes   | ?         | alpha       | |
| @subpage node-type-exec         | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-file         | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-fpga         | no                | ?     | yes  | yes   | ?         | beta        | |
| @subpage node-type-iec61850-8-1 | no                |       | yes  | yes   | 1         | alpha       | |
| @subpage node-type-iec61850-9-2 | no                |       | yes  | yes   | 1         | beta        | |
| @subpage node-type-infiniband   | no                | ?     | yes  | yes   | unlimited | beta        | |
| @subpage node-type-influxdb     | no                | N/A   | no   | yes   | unlimited | stable      | |
| @subpage node-type-loopback     | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-mqtt         | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-nanomsg      | yes               | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-ngsi         | no                | AIO   | yes  | yes   | unlimited | stable      | Use WebSockets for Live data |
| @subpage node-type-opal         | no                | Poll  | yes  | yes   | 1         | untested    | |
| @subpage node-type-rtp          | yes               | Poll  | yes  | yes   | ?         | beta        | |
| @subpage node-type-shmem        | no                | Poll  | yes  | yes   | unlimited | stable      | |
| @subpage node-type-signal       | no                | AIO   | yes  | no    | 1         | stable      | |
| @subpage node-type-socket       | yes               | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-stats        | no                | Poll  | yes  | no    | 1         | stable      | |
| @subpage node-type-test-rtt     | no                | AIO   | yes  | yes   | unlimited | stable      | Virtual node-type |
| @subpage node-type-uldaq        | no                | Poll  | yes  | no    | unlimited | stable      | |
| @subpage node-type-websocket    | no                | AIO   | yes  | yes   | unlimited | stable      | |
| @subpage node-type-zeromq       | yes               | AIO   | yes  | yes   | unlimited | stable      | |

@image html VILLASnode_interfaces.svg width=100%
