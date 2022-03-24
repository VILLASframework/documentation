---
sidebar_position: 1
sidebar_label: Overview
---

# Clients {#node-clients}

In addition to the supported [node-types](../nodes/index.md), VILLASnode comes with examples for third-party applications and model blocks.
These clients usually use the [`socket` node-type](../nodes/socket.md) to exchange data with a VILLASnode instance via UDP packets.
For details about the UDP packet format, checkout the [respective format docs](../formats/villas_binary.md).

- [MATLAB](matlab.md):
    Simple MATLAB code for exchanging signals via UDP sockets between MATLAB and VILLASnode.

- [OPAL-RT Hypersim](opal_hypersim.md):
    A user code model for OPAL-RTs HYPERSIM digital real-time simulator using UDP sockets for interfacing to VILLASnode.

- [OPAL-RT AsyncIP](opal_async_ip.md):
    Contains the implementation of an asynchronous process block for RT-LAB.

- [Python](python.md):
    A simple python client application communicating via local Unix sockets and Protobuf encoding

- [NI LabVIEW](labview.md):
    This example model is using LabView standard UDP blocks to exchange sample values with VILLASnode via UDP packets.

- [RTDS GTNET-SKT](rtds_gtnet_skt.md):
    Several example RSCAD drafts showing how to use GTSYNC and GTNET-SKT together with VILLASnode.

- [RTDS GTFPGA](rtds_ml507_gtfpga.md):
    An alternative to [GTNET cards](rtds_gtnet_skt.md) for interfacing RTDS via UDP.

- [DPsim](https://git.rwth-aachen.de/acs/core/simulation/DPsim):
    VILLAsnode can communicate via the [`shmem` node-type](../nodes/shmem.md) with the dynamic phasor solver (DPsim) of the Institute for Automation of Complex Power Systems.
    Please contact [Markus Mirz](mailto:mmirz@eonerc.rwth-aachen.de) for details.
