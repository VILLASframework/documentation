---
hide_table_of_contents: true
---

# Statistic Collection

The `stats` hook collects statistics about nodes.
Currently the following metrics are collected:

| Identifier     | Unit    | Description                                               |
| :--            | :--     | :--                                                       |
| `skipped`      | samples | Skipped samples and the distance between them             |
| `reordered`    | samples | Reordered samples and the distance between them           |
| `gap_sent`     | seconds | Inter-message timestamps (as sent by remote)              |
| `gap_received` | seconds | Inter-message arrival time (as received by this instance) |
| `owd`          | seconds | One-way-delay (OWD) of received messages                  |


If the node to which this hook is attached an [`rtp` node-type](../nodes/rtp.md), the following additional statistics are collected from the RTP reception reports.
The contains details about the quality of service as seen be the receiver.

| Identifier             | Unit    | Description                         |
| :--                    | :--     | :--                                 |
| `rtp.loss_fraction`    | percent | Fraction lost since last RTP SR/RR. |
| `rtp.pkts_lost`        | packets | Cumulative number of packets lost.  |
| `rtp.jitter`           | seconds?| Inter-arrival jitter                 |


For each of the metrics the following moments / attributes are collected:

| Moment    | Type    | Description                                         |
|:--        |:--      |:--                                                  |
| `last`    | float   | The last collected value.                           |
| `highest` | float   | The highest/largest collected value.                |
| `lowest`  | float   | The lowest/smallest collected value.                |
| `mean`    | float   | The mean across all collected values.               |
| `var`     | float   | The variance across all collected values.           |
| `stddev`  | float   | The standard deviation across all collected values. |
| `total`   | integer | The total number of collected values.               |

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/stats.cpp


## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/stats" />

# Example

``` url="external/node/etc/examples/hooks/stats.conf" title="node/etc/examples/hooks/stats.conf"
stats = 1

nodes = {
    signal_node = {
        type = "signal"
        signal = "mixed"
        values = 5
        rate = 50

        in = {
            hooks = (
                {
                    type = "stats"

                    verbose = true
                    warmup = 10
                    buckets = 25
                }
            )
        }
    }
}

paths = (
    {
        in = "signal_node"
    }
)
```
