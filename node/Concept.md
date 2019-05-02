# Concept {#node-concept}

VILLASnode is designed around the concept of _super nodes_, _nodes_, _paths_ and _hooks_.
It's the task of the server to forward real-time simulation data between multiple parties.
In doing so, the server has to perform simple checks and collects statistics.
From the viewpoint of the communication parters the server is nearly transparent.
Hence, it's cruical to keep the added overhead as low as possible (in terms of latency).

- @subpage node-concept-supernode
- @subpage node-concept-node
- @subpage node-concept-path
- @subpage node-concept-signals
- @subpage node-concept-hook
- @subpage node-concept-sample
