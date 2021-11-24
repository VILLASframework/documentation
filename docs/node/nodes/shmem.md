# Shared memory {#node-type-shmem}

The `shmem` node-type can be used to quickly exchange samples with a process on the same host using a POSIX shared memory object.

# Prerequisites {#node-type-shmem-prereq}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-type-shmem-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/shmem.cpp


# Configuration {#node-config-node-shmem}

The only required configuration option is the `name` option; all others are optional with reasonable defaults.

## in.name (string) {#node-config-node-shmem-in-name}

## out.name (string) {#node-config-node-shmem-out-name}

Name of the POSIX shared memory object. Must start with a forward slash (`/`).
The same name should be passed to the external program somehow in its
configuration or command-line arguments.

## queuelen (int) {#node-config-node-shmem-queuelen}

Length of the input and output queues in elements. Defaults to `DEFAULT_SHMEM_QUEUELEN`,
a compile-time constant.

## samplelen (int) {#node-config-node-shmem-samplelen}

Maximum number of data elements in a single `struct sample` for the samples handled
by this node. Defaults to `DEFAULT_SHMEM_SAMPLELEN`, a compile-time constant.

## mode (string: "pthread" | "polling") = "pthread" {#node-config-node-shmem-mode}

If set to `pthread`, POSIX condition variables are used to signal writes between processes.
If set to `polling`, no CV's are used, meaning that blocking writes have to be
implemented using polling, leading to performance improvements at a cost of
unnecessary CPU usage. Defaults to `pthread`.

## exec (array of strings) {#node-config-node-shmem-exec}

Optional name and command-line arguments (as passed to `execve`) of a command
to be executed during node startup. This can be used to start the external
program directly from VILLASNode. If unset, no command is executed.

# Example {#node-type-shmem-example}

@include node/etc/examples/nodes/shmem.conf

# API for external programs {#node-type-shmem-api}

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
