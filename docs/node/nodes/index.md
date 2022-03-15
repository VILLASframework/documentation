---
sidebar_position: 1
sidebar_label: Overview
hide_table_of_contents: true
---

# Node-types

All communication partners which are interfaced by the VILLASnode gateway are represented by nodes.
These nodes act as sinks / sources for simulation data.
Every node is an instance of a node-type. In a single VILLASnode instance, multiples instances of the same node-type can be created at the same time.

<figure align="center">
    <img alt="VILLASnode interfaces" src="/img/VILLASnode_interfaces.svg" width="100%" />
    <figcaption>Excert of interfaces supported by VILLASnode.</figcaption>
</figure>

VILLASnode currently supports the following node-types:

| Type                              | Network Emulation | Read | Write | Vectorize | Status      | Comments |
| :--                               | :--               | :--  | :--   | :--       | :--         | :--      |
| [amqp](amqp.md)                   | no                | yes  | yes   | unlimited | stable      | |
| [can](can.md)                     | no                | yes  | yes   | ?         | beta        | |
| [comedi](comedi.md)               | no                | yes  | yes   | unlimited | beta        | Support for a wide range of Analog/Digital Input/Output cards |
| [ethercat](ethercat.md)           | no                | yes  | yes   | ?         | alpha       | |
| [exec](exec.md)                   | no                | yes  | yes   | unlimited | stable      | |
| [file](file.md)                   | no                | yes  | yes   | unlimited | stable      | |
| [fpga](fpga.md)                   | no                | yes  | yes   | ?         | beta        | |
| [iec61850-8-1](iec61850-8-1.md)   | no                | yes  | yes   | 1         | alpha       | |
| [iec61850-9-2](iec61850-9-2.md)   | no                | yes  | yes   | 1         | beta        | |
| [infiniband](infiniband.md)       | no                | yes  | yes   | unlimited | beta        | |
| [influxdb](influxdb.md)           | no                | no   | yes   | unlimited | stable      | |
| [kafka](kafka.md)                 | yes               | yes  | yes   | unlimited | stable      | |
| [loopback](loopback.md)           | no                | yes  | yes   | unlimited | stable      | |
| [mqtt](mqtt.md)                   | no                | yes  | yes   | unlimited | stable      | |
| [nanomsg](nanomsg.md)             | yes               | yes  | yes   | unlimited | stable      | |
| [ngsi](ngsi.md)                   | no                | yes  | yes   | unlimited | stable      | Use WebSockets for Live data |
| [opal](opal.md)                   | no                | yes  | yes   | 1         | untested    | |
| [redis](redis.md)                 | no                | yes  | yes   | unlimited | stable      | |
| [rtp](rtp.md)                     | yes               | yes  | yes   | ?         | beta        | |
| [shmem](shmem.md)                 | no                | yes  | yes   | unlimited | stable      | |
| [signal](signal.md)               | no                | yes  | no    | 1         | stable      | |
| [socket](socket.md)               | yes               | yes  | yes   | unlimited | stable      | |
| [stats](stats.md)                 | no                | yes  | no    | 1         | stable      | |
| [temper](temper.md)               | no                | yes  | no    | unlimited | stable      | |
| [test-rtt](test-rtt.md)           | no                | yes  | yes   | unlimited | stable      | Virtual node-type |
| [uldaq](uldaq.md)                 | no                | yes  | no    | unlimited | stable      | |
| [websocket](websocket.md)         | no                | yes  | yes   | unlimited | stable      | |
| [zeromq](zeromq.md)               | yes               | yes  | yes   | unlimited | stable      | |
