# Statistic collection {#hook-type-stats}

The `stats` hook collects statistics about nodes.
Currently the following metrics are collected:

| Identifier     | Unit    | Description                                               |
| :--            | :--     | :--                                                       |
| `skipped`      | samples | Skipped samples and the distance between them             |
| `reordered`    | samples | Reordered samples and the distance between them           |
| `gap_sent`     | seconds | Inter-message timestamps (as sent by remote)              |
| `gap_received` | seconds | Inter-message arrival time (as received by this instance) |
| `owd`          | seconds | One-way-delay (OWD) of received messages                  |


If the node to which this hook is attached is of type @ref node-type-rtp, the following additional statistics are collected from the RTP receiption reports.
The contains details about the quality of service as seen be the receiver.

| Identifier             | Unit    | Description                         |
| :--                    | :--     | :--                                 |
| `rtp.loss_fraction`    | percent | Fraction lost since last RTP SR/RR. |
| `rtp.pkts_lost`        | packets | Cumulative number of packtes lost.  |
| `rtp.jitter`           | seconds?| Interarrival jitter                 |


For each of the metrics the following moments / attrbributes are collected:

| Moment    | Type    | Description                                         |
|:--        |:--      |:--                                                  |
| `last`    | float   | The last collected value.                           |
| `highest` | float   | The highest/largest collected value.                |
| `lowest`  | float   | The lowest/smallest collected value.                |
| `mean`    | float   | The mean across all collected values.               |
| `var`     | float   | The variance across all collected values.           |
| `stddev`  | float   | The standard deviation across all collected values. |
| `total`   | integer | The total number of collected values.               |

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/stats.cpp


# Configuration {#node-config-hook-stats}

## format (string: "json" | "matlab" | "human") = "human" {#node-config-hook-stats-format}

The output format used to print the statistics at shutdown.

## buckets (integer) = 20 {#node-config-hook-stats-buckets}

The number of buckets which should be used for the underlying histograms.

## warmup (integer) = 500 {#node-config-hook-stats-warmup}

Use the first `warmup` samples to estimate the bucket range of the underlying histograms.

## verbose (boolean) = false {#node-config-hook-stats-verbose}

Include full dumps of the histogram buckets into the output.

## output (string: uri) {#node-config-hook-stats-output}

The file where you want to write the report to.
If omitted, stdout (the terminal) will be used.

## Example

@include node/etc/examples/hooks/stats.conf
