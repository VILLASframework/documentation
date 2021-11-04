# villas node {#node-usage-node}

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas node` daemon.
The folling usage information is provided when called like `villas node -`:

@include node/usage/villas-node.txt

The server requires root privileges to:

 - Enable the realtime FIFO scheduler
 - Increase the task priority
 - Configure the [network emulator](../netem.md)
 - Change the SMP affinity of threads and network interrupts

# Usage

@include node/usage/villas-node.txt
