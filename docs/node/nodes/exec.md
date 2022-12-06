---
hide_table_of_contents: true
---

# Sub-process Execution

The `exec` node-type spawns a new subprocess and exchanges sample data via `stdin` and `stdout`.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/exec.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/exec" />

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
