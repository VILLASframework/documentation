# Concept {#node-concept}

VILLASnode is designed around the concept of _nodes_, _super nodes_ and _paths_.
It's the task of the server to forward real-time simulation data between multiple parties.
In doing so, the server has to perform simple checks and collects statistics.
From the viewpoint of the communication parters the server is nearly transparent.
Hence, it's cruical to keep the added overhead as low as possible (in terms of latency).

- @subpage node-concept-supernode
- @subpage node-concept-node
- @subpage node-concept-path
- @subpage node-concept-hook

## Interface

Interfaces are used to represent physical network ports on the server.
They are only used by the [Socket](@ref node-type-socket) type of nodes.

@todo Add documentation

@see interface for implementation details.
