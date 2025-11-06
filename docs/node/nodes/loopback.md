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
https://github.com/VILLASframework/node/blob/master/lib/nodes/loopback.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/loopback" />

## Example

``` url="external/node/etc/examples/nodes/loopback.conf" title="node/etc/examples/nodes/loopback.conf"
nodes = {
    loopback_node = {
        # A loopback node will receive exactly the same data which has been sent to it
        type = "loopback"

        # The internal implementation is based on queue
        # The queue length of the internal queue which buffers the samples
        queuelen = 1024

        # Use busy polling for synchronization of the read and write side of the queue
        mode = "polling"
    }
}
```
