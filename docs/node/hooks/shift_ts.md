---
hide_table_of_contents: true
---

# Shift Timestamps

The hook `shift_ts` is designed to shift timestamps by applying a specified offset in seconds. 
The hook can shift either the origin or received timestamp of each sample, based on the configuration.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/shift_ts.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/shift_ts" />

## Example

``` url="external/node/etc/examples/hooks/shift_ts.conf" title="node/etc/examples/hooks/shift_ts.conf"
@include "hook-nodes.conf"

paths = (
    {
        in = "signal_node"
        out = "file_node"

        hooks = (
            {
                type = "shift_ts"

                mode = "origin"
                offset = 5.5
            }
        )
    }
)
```
