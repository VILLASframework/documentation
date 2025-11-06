---
hide_table_of_contents: true
---

# File

The `file` node-type can be used to log or replay samples to / from disk.

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/file.cpp

## Configuration {#config}

Every `file` node can be configured to only read or write or to do both at the same time.
The node configuration is divided into two sub-groups: `in` and `out`.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/file" />

## Example

``` url="external/node/etc/examples/nodes/file.conf" title="node/etc/examples/nodes/file.conf"
nodes = {
    file_node = {
        type = "file"

        # These options specify the URI where the the files are stored
        # The URI accepts all format tokens of (see strftime(3))
        uri = "logs/input.log"
        # uri = "logs/output_%F_%T.log"

        format = "csv"

        in = {
            # One of: direct (default), wait, relative, absolute
            epoch_mode = "direct"

            # The interpretation of this value depends on epoch_mode (default is 0)
            # Consult the documentation of a full explanation
            epoch = 10

            # A constant rate at which the lines of the input files should be read
            # A missing or zero value will use the timestamp in the first column
            # of the file to determine the pause between consecutive lines
            rate = 2.0

            # Rewind the file and start from the beginning
            eof = "rewind"

            # Creates a stream buffer if value is positive
            buffer_size = 0
        }

        out = {
            # Flush or upload contents of the file every time new samples are sent
            flush = false

            # Creates a stream buffer if value is positive
            buffer_size = 0
        }
    }
}
```
