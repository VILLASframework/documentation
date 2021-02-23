# Global {#node-config-global}

The global section consists of some global configuration parameters:

## stats (float) {#node-config-stats}

Specifies the rate at which statistics about the active paths will be periodically printed to the screen.

Setting this value to 5, will print 5 lines per second.

A line includes information such as:

  - Source and Destination of path
  - Messages received
  - Messages sent
  - Messages dropped

## affinity (integer) {#node-config-affinity}

Restricts the exeuction of the daemon to certain CPU cores.
This technique, also called 'pinning', improves the determinism of the server by isolating the daemon processes on exclusive cores.

## priority (integer) {#node-config-priority}

Adjusts the scheduling priority of the deamon processes.
By default, the daemon uses a real-time optimized FIFO scheduling algorithm.

## hugepages (integer) {#node-config-hugepages}

The number of hugepages which will be reservered by the system.

See: <https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt>

## name (string) = hostname {#node-config-name}

By default the `name` of a VILLASnode instance is equal to the hostname of the machine it is running on.
Some node types are using this name to identify themselves agains their remotes.
An example is the `ngsi` node type which adds a metadata attribute `source` to its updates.