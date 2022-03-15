---
hide_table_of_contents: true
---

# Shared memory

The `shmem` node-type can be used to quickly exchange samples with a process on the same host using a POSIX shared memory object.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/shmem.cpp

## Configuration {#config}

The only required configuration option is the `name` option; all others are optional with reasonable defaults.

### in.name (string)

### out.name (string)

Name of the POSIX shared memory object. Must start with a forward slash (`/`).
The same name should be passed to the external program somehow in its
configuration or command-line arguments.

### queuelen (int)

Length of the input and output queues in elements. Defaults to `DEFAULT_SHMEM_QUEUELEN`,
a compile-time constant.

### samplelen (int)

Maximum number of data elements in a single `struct sample` for the samples handled
by this node. Defaults to `DEFAULT_SHMEM_SAMPLELEN`, a compile-time constant.

### mode (string: "pthread" | "polling") = "pthread"

If set to `pthread`, POSIX condition variables are used to signal writes between processes.
If set to `polling`, no CV's are used, meaning that blocking writes have to be
implemented using polling, leading to performance improvements at a cost of
unnecessary CPU usage. Defaults to `pthread`.

### exec (array of strings)

Optional name and command-line arguments (as passed to `execve`) of a command
to be executed during node startup. This can be used to start the external
program directly from VILLASNode. If unset, no command is executed.

## Example

``` url="external/node/etc/examples/nodes/shmem.conf" title="node/etc/examples/nodes/shmem.conf"
nodes = {
	shmem_node = {
		type = "shmem",
		
		in = {
			name = "sn1_in"
		},					# Name of shared memory segment for receiving side
		out = {
			name = "sn1_in"			# Name of shared memory segment for sending side
		},

		queuelen = 1024,			# Length of the queues
		mode = "pthread",			# We can busy-wait or use pthread condition variables for synchronizations
		
		# Execute an external process when starting the node which
		# then starts the other side of this shared memory channel
		# Usually we also pass the shmem names as parameters.
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

See the [example client](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/clients/shmem/villas-shmem.cpp) and the [API
](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/include/villas/shmem.h) for more details.
