---
hide_table_of_contents: true
---

# Phasor calculation

The `pmu_dft` hook provides a dft based phasor calculation. The current implementation is a proof of concept but should not be used in production since this implementation is rather resource hungry.

This version supports phasor estimation for the frequency and amplitude but not yet for the phase.

This hook removes all signals fed into it and replaces it with new signals called amplitude, frequency, phase, rocof. If `add_channel_name` is set to `false` this could result in duplicate channel names.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/pmu_dft.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/pmu_dft" />

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

				sample_rate = 1000,			# sample rate of the input signal
				dft_rate = 10,				# number of phasors calculated per second

				start_frequency = 49.7,			# lowest frequency bin
				end_frequency = 50.3,			# highest frequency bin
				frequency_resolution = 0.1,		# frequency bin resolution

				window_size_factor = 1,			# a factor with which the window will be increased
				window_type = "hamming",		# one of: flattop, hamming, hann
				padding_type = "zero", 			# one of: signal_repeat, zero
				frequency_estimate_type = "quadratic", # one of: quadratic

				pps_index = 0,				# signal index of the PPS signal
				
				angle_unit = "rad" 			# one of: rad, degree
			}
		)
	}
)
```
