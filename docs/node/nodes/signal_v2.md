---
hide_table_of_contents: true
---

# Signal Generator (v2)

The `signal.v2` node-type is a simple signal generator which can be used to generate sine, square, ramp, triangle or random signals at user definable frequencies, rates, amplitudes.
Its a re-implementation of the original [`signal` node-type](./signal.md) which just changed the way of configuration.

Most commonly it is used for testing when no real simulation data is available.

**Note:** There is also the [`villas-signal` tool](../usage/villas-signal.md) which has a similar purpose.

# Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/signal_v2.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/signal_v2_node" />

## Example

``` url="external/node/etc/examples/nodes/signal-v2.conf" title="node/etc/examples/nodes/signal-v2.conf"
nodes = {
    signal_node = {
        type = "signal.v2"

        rate = 10.0

        # Wait between emitting each sample
        realtime = true

        # Only emit 1000 samples, then stop
        limit = 1000

        # Count and warn about missed steps
        monitor_missed = true

        in = {
            signals = (
                { name = "sine1",   signal = "sine",   amplitude = 123.456, frequency = 10, offset = 1.0   },
                { name = "sine2",   signal = "sine",   amplitude = 12.456,  frequency = 20, offset = 10.0  },
                { name = "sine3",   signal = "sine",   amplitude = 2,       frequency = 1,  offset = 100.0 },
                { name = "random1", signal = "random", amplitude = 2, stddev = 2,           offset = 13.0  },
                { name = "pulse1",  signal = "pulse",  frequency = 1.0, pulse_width = 1, pulse_high = 100, pulse_low = 50 }
            )
        }
    }

    signal_node2 = {
        type = "signal.v2"

        in = {
            signals = {
                count = 8
                signal = "mixed"
            }
        }
    }
}
```
