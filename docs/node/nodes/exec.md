---
hide_table_of_contents: true
---

# Sub-process Execution

The `exec` node-type spawns a new subprocess and exchanges sample data via `stdin` and `stdout`.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/exec.cpp

## Configuration {#config}

### format (string: format-id) = "villas.human"

A IO format identifier selecting the file format which is used for reading and writing from the file.

See [Format Types](../formats/index.md) for a complete list of supported formats.

### shell (boolean) = false

If set, the @node-config-node-exec-exec setting gets passed the shell (`/usr/bin`). 
In this case the `exec` setting must be given as a string.

If not set, we will directly execute the sub-process via `execvpe(2)`.
In this case the `exec` setting must be given as an array (`argv[]`).

### exec (string|array)

The program which should be execed in the sub-process.

The options is passed to the system shell for execution.

### flush (boolean) = true

Flush stream every time VILLASnode passes data the sub-process.

### working_directory (string: path)

If set, the working directory for the sub-process will be changed.

### environment (object)

A object of key/value pairs of environemnt variables which should be passed to the sub-process **in addition** to the parent environment.

## Example

``` url="external/node/etc/examples/nodes/exec.conf" title="node/etc/examples/nodes/exec.conf"
nodes = {
	exec_node = {
		type = "exec"
		format = "villas.human"
		flush = true
		exec = "tee test"
		shell = true
		working_directory = "/tmp"
		environment = {
			MYVAR = "TESTVAL"
		}
	}
}
```
