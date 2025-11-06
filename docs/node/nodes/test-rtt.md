---
hide_table_of_contents: true
---

# Test Round-trip Time

The `test_rtt` node-type is a virtual node-type which can be used to measure round-trip time to other nodes.
The `test_rtt` nodes periodically generate probes which must be looped back via a second node.

:::info Hint for `raw` format
If your second node is using the `raw` format you will need to set the `fake = true` setting in the format configuration.

Otherwise, no sample meta data such as time stamps are exchanged. However, these are required by the `test_rtt` node-type to calculate the round-trip time.
:::

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/test_rtt.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/test_rtt" />

## Example

``` url="external/node/etc/examples/nodes/test_rtt.conf" title="node/etc/examples/nodes/test_rtt.conf"
nodes = {

    # The "test_rtt" node-type runs a set of test cases for varying
    # sending rates, number of values and generates statistics
    # The cooldown time between each test case in seconds
    rtt_node = {
        type = "test_rtt"
        cooldown = 2

        # An optional prefix in the filename
        prefix = "test_rtt_%y-%m-%d_%H-%M-%S"

        # The output directory for all results
        # The results of each test case will be written to a separate file
        output = "./results"

        # The output format of the result files
        format = "villas.human"

        # Shutdown the process after the cooldown phase of the
        # last test case has been completed.
        shutdown = true;

        # One of:
        # - min
        # - max
        # - at_least_count
        # - at_least_duration
        # - stop_after_count
        # - stop_after_duration
        mode = "at_least_count"

        # The list of test cases
        # Each test case can specify a single or an array of rates and values
        # If arrays are used, we will generate multiple test cases with all
        # possible combinations
        cases = (
            {
                # The sending rate in Hz
                rates = 55.0

                # The number of values which should be send in each sample
                values = [ 5, 10, 20]

                # The number of samples which should be send during this test case
                count = 100
            },
            {
                # An array of sending rates in Hz
                rates = [ 5, 10, 30 ]

                # An array of number of values
                values = [ 2, 10, 20 ]

                # The duration of the test case in seconds (depending on the sending rate)
                duration = 5
            }
        )
    }
}
```
