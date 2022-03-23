---
hide_table_of_contents: true
---

# Loopback

The `loopback` node-type loops back every sample which has been sent to it.
Internally it is implemented by a FIFO queue.

It can be used to **chain multiple** [paths](../config/paths.md) together by using the same [`loopback`](../nodes/loopback.md) node as an output node in the first path and as a source in the second path.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/loopback.cpp

## Configuration {#config}

### queuelen (integer)

The queue length of the internal queue which buffers the samples.

### samplelen (integer)

The number of values each buffered sample can store.

### mode (string: "pthread" | "polling" | "pipe" | "eventfd" | "auto") = "auto"

Specify the synchronization mode of the internal queue.

## Example

``` url="external/node/etc/examples/nodes/loopback.conf" title="node/etc/examples/nodes/loopback.conf"
nodes = {
	loopback_node = {
		type = "loopback",			# A loopback node will receive exactly the same data which has been sent to it.
							# The internal implementation is based on queue.
		queuelen = 1024,			# The queue length of the internal queue which buffers the samples.
		mode = "polling"			# Use busy polling for synchronization of the read and write side of the queue
	}
}
```
