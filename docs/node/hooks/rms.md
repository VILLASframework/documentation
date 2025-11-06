---
hide_table_of_contents: true
---

# Root-Mean-Square Calculation

The `rms` hook calculates the RMS of signals on a given window.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/rms.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/rms" />

## Example

``` url="external/node/etc/examples/hooks/rms.conf" title="node/etc/examples/hooks/rms.conf"
@include "hook-nodes.conf"

paths = (
    {
        in = "signal_node"
        out = "file_node"

        hooks = (
            {
                type = "rms",

                window_size = 1000

                signals = [
                    "sine"
                ]
            }
        )
    }
)
```
