---
title: VILLASnode
sidebar_position: 1
sidebar_label: Overview
---

# VILLASnode <img src="/img/logos/villas_node.svg" width="100" align="right" />

VILLASnode is a modular gateway for simulation data.
It offers interfaces to simulation equipment, databases and web services.

:::info
Please have a look at our **[Getting Started Guide](./guides/getting_started.md)**!
:::

## Overview

The project consists of a server daemon and several client modules which are documented here.

## Features

- Wide selection of [interface types](nodes/index.md)
- Statistic collection for the quality of service of the interfaces
- Web interface for live monitoring and control using WebSocket streams
- [Remote API](development/api.md) for control via HTTP
- Lua-scriptable hook functions
- Network emulation using the Linux [netem queuing discipline](https://wiki.linuxfoundation.org/networking/netem)
- Multicast addressing for the [socket node type](nodes/socket.md)
- Deterministic and low jitter due to a low-level C/C++ implementation
  - Uses the latest C11/C++17 standards
  - Is easily extensible with new interface types, hook functions, and payload formats
- Is released as open-source software under the GPLv3 license
- Is easily deployable via [precompiled standalone binaries](./installation.md#standalone), a [Docker image](./installation.md#docker), or from [source](./installation.md#source)
- Relies only on open-source software libraries and the Linux kernel
- Follows the Unix philosophy by providing a set of smaller command-line tools

## Daemon

The server simply acts as a gateway to forward simulation data from one client to another.
Furthermore, it collects statistics, monitors the quality of service, and handles encryption or tunneling through VPNs.

For optimal performance, the server is implemented in low-level C and makes use of several Linux-specific real-time features.
The primary design goal was to make the behavior of the system as deterministic as possible.
Therefore, it is advisable to run the server component on a [`PREEMPT_RT`](https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch)-patched version of Linux. In our environment, we use a Fedora-based distribution that has been stripped to the bare minimum (no GUI, only a few background processes).
Have a look at [Tuning](tuning.md) for ways to improve the real-time performance of your system.

## Clients

There are two types of interfaces to VILLASnode:

1.  The server handles different types of nodes.
    The most commonly used node type is the [socket node type](nodes/socket.md), which allows communication over network links (UDP, raw IP, raw Ethernet frames).
    However, there are also other specialized node types to retrieve or send data to equipment that is directly connected to or running on the server itself.
    An example of such a node is the [VILLASfpga node type](nodes/fpga.md), which directly fetches and pushes data to a PCIe card.
    Or the [file node type](nodes/file.md), which logs or replays simulation data from the hard disk.

2. Another way to connect simulation equipment is by using a client application that sends the data over the network to VILLASnode.
    In this scenario, VILLASnode uses the [socket node type](nodes/socket.md) to communicate with the client application.

Usually, new clients or equipment should be implemented as a new node type as part of VILLASnode.
Using a dedicated client application that communicates via the 'socket' type is deprecated because it leads to code duplication.
