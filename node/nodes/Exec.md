# Sub-process Execution {#node-type-exec}

The `exec` node-type spawns a new subprocess and exchanges sample data via `stdin` and `stdout`.

# Prerequisites {#node-prereq-exec}

This node-type does not have any special library dependencies. It is always available.

# Configuration {#node-config-node-exec}

## format (string: format-id) = "villas.human" {#node-config-node-file-format}

A IO format identifier selecting the file format which is used for reading and writing from the file.

See @ref node-formats for a complete list of supported formats.

## exec (string) {#node-config-node-exec-exec}

The program which should be execed in the sub-process.

The options is passed to the system shell for execution.

## flush (boolean) = false {#node-config-node-exec-flush}

Flush the stream after every access.

## Example

@include node/etc/examples/nodes/exec.conf

# Implementation {#node-implementation-exec}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/exec.c
