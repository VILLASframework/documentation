---
hide_table_of_contents: true
---

# Shared memory

The `shmem` node-type can be used to quickly exchange samples with a process on the same host using a POSIX shared memory object.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/shmem.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/shmem" />

## Example

``` url="external/node/etc/examples/nodes/shmem.conf" title="node/etc/examples/nodes/shmem.conf"
nodes = {
    shmem_node = {
        type = "shmem"

        in = {
            # Name of shared memory segment for receiving side
            name = "sn1_in"
        }

        out = {
            # Name of shared memory segment for sending side
            name = "sn1_in"
        }

        # Length of the queues
        queuelen = 1024

        # We can busy-wait or use pthread condition variables for synchronizations
        mode = "pthread"

        # Execute an external process when starting the node which
        # then starts the other side of this shared memory channel
        # Usually we also pass the shmem names as parameters
        exec = [ "villas-shmem", "sn1_in", "sn1_out" ]
    }
}
```

## API for external programs

The actual sharing of data is implemented by putting two shared `struct queue`s
(one per direction) and an associated `struct pool` in the shared memory region.
Samples can be exchanged by simply writing to and reading from these queues.

External programs that want to use this interface must link against
`libvillas.so`.

The interface for external programs is very simple: after opening the shared
memory object with `shmem_shared_open` (passing the object name from the
configuration file), samples can be read from and written to VILLASNode using
`shmem_shared_read` and `shmem_shared_write`, respectively. Samples written to
the node must be allocated by `sample_alloc` from the shared pool; samples read
from the node should be freed with `sample_put` after they have been processed.

See the [example client](https://github.com/VILLASframework/node/blob/master/clients/shmem/villas-shmem.cpp) and the [API
](https://github.com/VILLASframework/node/blob/master/include/villas/shmem.h) for more details.
