---
hide_table_of_contents: true
---

# File

The `file` node-type can be used to log or replay samples to / from disk.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/file.cpp

## Configuration {#config}

Every `file` node can be configured to only read or write or to do both at the same time.
The node configuration is divided into two sub-groups: `in` and `out`.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/file" />

## Example

``` url="external/node/etc/examples/nodes/file.conf" title="node/etc/examples/nodes/file.conf"
nodes = {
	file_node = {
		type	= "file"

	### The following settings are specific to the file node-type!! ###

		uri = "logs/input.log",			# These options specify the URI where the the files are stored
		#uri = "logs/output_%F_%T.log"		# The URI accepts all format tokens of (see strftime(3))

		format = "csv"

		in = {
			epoch_mode = "direct"		# One of: direct (default), wait, relative, absolute
			epoch = 10			# The interpretation of this value depends on epoch_mode (default is 0).
							# Consult the documentation of a full explanation

			rate = 2.0			# A constant rate at which the lines of the input files should be read
							# A missing or zero value will use the timestamp in the first column
							# of the file to determine the pause between consecutive lines.
			eof = "rewind"			# Rewind the file and start from the beginning.

			buffer_size = 0			# Creates a stream buffer if value is positive
		},
		out = {
			flush = false			# Flush or upload contents of the file every time new samples are sent.

			buffer_size = 0			# Creates a stream buffer if value is positive
		}
	}
}
```
