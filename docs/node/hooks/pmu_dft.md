---
hide_table_of_contents: true
---

# Round signals

The `pmu_dft` hook provides a dft based phasor calculation. The current implementation is a proof of concept but should not be used in production since this implementation is rather resource hungry.

This version supports phasor estimation for the frequency and amplitude but not yet for the phase.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/pmu_dft.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/pmu_dft" />

## Example

``` url="external/node/etc/examples/hooks/pmu_dft.conf" title="node/etc/examples/hooks/pmu_dft.conf"
@include "hook-nodes.conf"

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "pmu_dft",

				signals = (
					"sine"
				)

				sample_rate = 1000,
				dft_rate = 10,

				start_freqency = 49.7,
				end_freqency = 50.3,
				frequency_resolution = 0.1,

				window_size_factor = 1,
				window_type = "hamming",
				padding_type = "zero",
				ffrequency_estimate_type = "quadratic",

				pps_index = 0,
				
				angle_unit = "rad"
			}
		)
	}
)
```
