---
hide_table_of_contents: true
---

# PPS Timestamping

The `pps_ts` hook sets the timestamps of samples based on a PPS signal/edge within the sample.

A common use-case is the accurate time-tagging of sample data acquired via an Analog to Digital Converter (ADC).
Some ADC solutions are interfaced via non real-time interfaces like Ethernet or USB like for example the ones supported by the [`uldaq`](../nodes/uldaq.md) node-type.
In these cases timestamping the measured signal with the current system time of the host system will be subject to an inaccuracy caused by the communication delay between the host system and the ADC.

The `pps_ts` hook solves this issue by using a pulse-per-second (PPS) signal which is sampled by the same ADC as the other signals.
A cheap solution for generating PPS signals are of-the-shelf GPS receiver modules.

The hook detects the PPS signal and re-timestamps the samples based on this signal. 

<figure align="center">
	<img alt="Timestamping via sampled PPS signal." src="/img/drawio/pps_ts.svg" width="50%" />
	<figcaption>Timestamping via sampled PPS signal.</figcaption>
</figure>

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/pps_ts.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/pps_ts" />

## Example

``` url="external/node/etc/examples/hooks/pps_ts.conf" title="node/etc/examples/hooks/pps_ts.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "pps_ts"

				signal = "pps"

				mode = "simple" # Oneof: simple, horizon
				threshold = 0.5
				expected_smp_rate = 5e3
				horizon_estimation = 10
				horizon_compensation = 10
			}
		)
	}
)
```
