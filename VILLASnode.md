# VILLASnode {#node}

<img src="images/logos/villas_node.svg" width="100" align="right" />

VILLASnode is a modular gateway for simulation data. It offers interfaces to simulation equipment, databases and web services.

- @subpage node-installation
- @subpage node-config
- @subpage node-guide
- @subpage node-usage
- @subpage node-types
- @subpage node-clients
- @subpage node-tuning

- @subpage node-concept
- @subpage node-designgoals
- @subpage node-timing
- @subpage node-dev

## Overview

The project consists of a server daemon and several client modules which are documented here.

[TOC]

### Daemon

The server simply acts as a gateway to forward simulation data from one client to another.
Furthermore, it collects statistics, monitors the quality of service and handles encryption or tunneling through VPNs.

For optimal performance the server is implemented in low-level C and makes use of several Linux-specific realtime features.
The primary design goal was to make the behaviour of the system as deterministic as possible.
Therefore, it's advisable to run the server component on a [PREEMPT_RT](https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch) patched version of Linux. In our environment, we use Fedora-based distribution which has been stripped to the bare minimum (no GUI, only a few background processes).
Have a look at @ref node-tuning for ways to improve the real-time performance of your system.

### Clients

There are two types of interfaces to VILLASnode:

1.  The server handles diffrent types of nodes.
    The most commonly used node-type is the @ref node-type-socket node-type which allows communication over network links (UDP, raw IP, raw Ethernet frames).
    But there are also other specialized node types to retreive or send data to equipemnt, which is directly connected to or running on the server itself.
    An example for such a node is the  @ref node-type-fpga node-type which directly fetches and pushes data to a PCIe card.
    Or the @ref node-type-file node-type which logs or replays simulation data from the harddisk.

2. An other way to connect simulation equipment is by using a client-application which itself sends the data over the network to VILLASnode.
    In this scenario, VILLASnode uses the @ref node-type-socket node-type to communicate with the client-application.

Usually, new clients / equipemnt should be implemented as a new node-type as part of VILLASnode.
Using a dedicated client-application which communicates via the 'socket' type is deprecated because it leads to code duplication.