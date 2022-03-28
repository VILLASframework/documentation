---
sidebar_label: ULDAQ
hide_table_of_contents: true
---

# MCC Universal Library for Linux

Interface to [DAQ devices](https://www.mccdaq.com/PDFs/Manuals/Linux-hw.pdf) from [Measurement Computing](https://www.mccdaq.com).

This interface has been tested with the [MCC USB-200 Series](https://www.mccdaq.com/usb-data-acquisition/USB-200-Series.aspx) as used in RWTH-ACS's Low-Cost PMU.

## Prerequisites

This node-type requires [libuldaq](https://github.com/mccdaq/uldaq.git) (>= 1.0.0).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/uldaq.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/uldaq" />

## Example

``` url="external/node/etc/examples/nodes/uldaq.conf" title="node/etc/examples/nodes/uldaq.conf"
http = {
	enabled = false
}

nodes = {
	ul201 = {
		type = "uldaq"
		interface_type = "usb"
		in = {
			range = "bipolar-10",
			input_mode = "single-ended" 
			signals = (
				{ name = "ch0", type = "float", channel = 0 }
			)

			sample_rate = 5000,
			vectorize = 100
		}
	},

	vpmu = {
		type = "socket",
		layer = "udp",

		format = {
			type = "raw"
			bits = 32
			endianess = "big"
		}

		in = {
			address = "*:13001"

			signals = ()
		},
		out = {
			vectorize = 100
			address = "10.100.1.125:13000"
		}
	}
}

paths = (
	{
		in = "ul201",
		out = "vpmu"
	}
)
```
