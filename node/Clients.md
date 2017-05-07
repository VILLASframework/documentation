# Clients {#node-clients}

In addition to the supported @ref node-types, VILLASnode comes with examples for client applications / and model blocks.
These clients usually use the @ref node-type-socket node-type to exchange data with a VILLASnode instance via UDP packets.
For details about the UDP packet format, please see @ref node-type-socket-format.

- @subpage node-client-asyncip
    Contains the implementation of an asynchronous process block for RT-LAB.

- @subpage node-client-labview
    This example model is using LabView standard UDP blocks to exchange sample values with VILLASnode via UDP packets.

- @subpage node-client-gtnet
    Several example RSCAD drafts showing how to use GTSYNC and GTNET-SKT together with VILLASnode.