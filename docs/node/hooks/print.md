---
hide_table_of_contents: true
---

# Print Sample Data

The `print` hook prints processed samples to the standard output or into a file.
While doing so, it supports all the formats described here: [Format Types](../formats/index.md) .
It can also optionally prefix each line of output with a user definable prefix in order to distinguish the output of multiple `print` hooks.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/print.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/print" />

## Example

``` url="external/node/etc/examples/hooks/print.conf" title="node/etc/examples/hooks/print.conf"
@include "hook-nodes.conf"

paths = (
    {
        in = "signal_node"
        out = "file_node"

        hooks = (
            {
                type = "print",

                output = "print_output_file.log"
                format = "villas.human"
                # prefix = "[file_node] " # Prefix and output are exclusive settings!
            }
        )
    }
)
```
