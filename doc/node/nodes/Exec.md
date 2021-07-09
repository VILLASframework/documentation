# Sub-process Execution {#node-type-exec}

The `exec` node-type spawns a new subprocess and exchanges sample data via `stdin` and `stdout`.

# Prerequisites {#node-type-exec-prereq}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-type-exec-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/exec.cpp

# Configuration {#node-config-node-exec}

## format (string: format-id) = "villas.human" {#node-config-node-file-format}

A IO format identifier selecting the file format which is used for reading and writing from the file.

See @ref node-formats for a complete list of supported formats.

## shell (boolean) = false {#node-config-node-exec-shell}

If set, the @node-config-node-exec-exec setting gets passed the shell (`/usr/bin`). 
In this case the `exec` setting must be given as a string.

If not set, we will directly execute the sub-process via `execvpe(2)`.
In this case the `exec` setting must be given as an array (`argv[]`).

## exec (string|array) {#node-config-node-exec-exec}

The program which should be execed in the sub-process.

The options is passed to the system shell for execution.

## flush (boolean) = true {#node-config-node-exec-flush}

Flush stream every time VILLASnode passes data the sub-process.

## working_directory (string: path) {#node-config-node-exec-working_directory}

If set, the working directory for the sub-process will be changed.

## environment (object) {#node-config-node-exec-environent}

A object of key/value pairs of environemnt variables which should be passed to the sub-process **in addition** to the parent environment.

# Example {#node-type-exec-example}

@include node/etc/examples/nodes/exec.conf
