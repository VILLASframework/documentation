---
hide_table_of_contents: true
---

# Signal Generator (v1)

:::caution Deprecation
This node-type is deprecated. Please use the newer [`signal.v2` node-type](./signal_v2.md).
:::

The `signal` node-type is a simple signal generator which can be used to generate sine, square, ramp, triangle or random signals at user definable frequencies, rates, amplitudes.

Most commonly it is used for testing when no real simulation data is available.

**Note:** There is also the [`villas-signal` tool](../usage/villas-signal.md) which has a similar purpose.

# Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/signal.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/signal_node" />

## Example

``` url="external/node/etc/examples/nodes/signal.conf" title="node/etc/examples/nodes/signal.conf"
nodes = {
    signal_node = {
        type = "signal"

        # One of "sine", "square", "ramp", "triangle", "random", "mixed", "counter"
        signal = [ "sine", "pulse", "square" ]

        # Number of values per sample
        values = 3

        # Amplitude of generated signals
        amplitude = [ 1.2, 0.0, 4.0 ]

        # Frequency of generated signals in Hz
        frequency = 10

        # Standard deviation of random signals (normal distributed)
        stddev = 2

        # Sample rate in Hz
        rate = 10.0

        # Constant offset
        offset = 1.0

        # Wait between emitting each sample
        realtime = true

        # Only emit 1000 samples, then stop
        limit = 1000

        # Count and warn about missed steps
        monitor_missed = true
    }
}
```
