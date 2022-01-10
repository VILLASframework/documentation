# MCC Universal Library for Linux {#node-type-uldaq}

Interface to [DAQ devices](https://www.mccdaq.com/PDFs/Manuals/Linux-hw.pdf) from [Measurement Computing](https://www.mccdaq.com).

This interface has been tested with the [MCC USB-200 Series](https://www.mccdaq.com/usb-data-acquisition/USB-200-Series.aspx) as used in RWTH-ACS's Low-Cost PMU.

# Prerequisites {#node-type-uldaq-prereq}

This node-type requires [libuldaq](https://github.com/mccdaq/uldaq.gitignore) (>= 1.0.0).

# Implementation {#node-type-uldaq-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/uldaq.cpp

# Configuration {#node-config-node-uldaq}

## device_id (string) ${node-config-uldaq-device_id}

## interface_type (string: "usb" | "bluetooth" | "ethernet" | "any" ) = "any" {#node-config-node-uldaq-in-interface_type}

## in.range (string) {#node-config-node-uldaq-in-range}

### Supported ranges

| Value            | Min     | Max    |
| :--------------- | :------ | :----- |
| `bipolar-60`     | -60.0   | +60.0  |
| `bipolar-60`     | -60.0   | +60.0  |
| `bipolar-30`     | -30.0   | +30.0  |
| `bipolar-15`     | -15.0   | +15.0  |
| `bipolar-20`     | -20.0   | +20.0  |
| `bipolar-10`     | -10.0   | +10.0  |
| `bipolar-5`      | -5.0    | +5.0   |
| `bipolar-4`      | -4.0    | +4.0   |
| `bipolar-2.5`    | -2.5    | +2.5   |
| `bipolar-2`      | -2.0    | +2.0   |
| `bipolar-1.25`   | -1.25   | +1.25  |
| `bipolar-1`      | -1.0    | +1.0   |
| `bipolar-0.625`  | -0.625  | +0.625 |
| `bipolar-0.5`    | -0.5    | +0.5   |
| `bipolar-0.25`   | -0.25   | +0.25  |
| `bipolar-0.125`  | -0.125  | +0.125 |
| `bipolar-0.2`    | -0.2    | +0.2   |
| `bipolar-0.1`    | -0.1    | +0.1   |
| `bipolar-0.078`  | -0.078  | +0.078 |
| `bipolar-0.05`   | -0.05   | +0.05  |
| `bipolar-0.01`   | -0.01   | +0.01  |
| `bipolar-0.005`  | -0.005  | +0.005 |
| `unipolar-60`    |  0.0    | +60.0  |
| `unipolar-30`    |  0.0    | +30.0  |
| `unipolar-15`    |  0.0    | +15.0  |
| `unipolar-20`    |  0.0    | +20.0  |
| `unipolar-10`    |  0.0    | +10.0  |
| `unipolar-5`     |  0.0    | +5.0   |
| `unipolar-4`     |  0.0    | +4.0   |
| `unipolar-2.5`   |  0.0    | +2.5   |
| `unipolar-2`     |  0.0    | +2.0   |
| `unipolar-1.25`  |  0.0    | +1.25  |
| `unipolar-1`     |  0.0    | +1.0   |
| `unipolar-0.625` |  0.0    | +0.625 |
| `unipolar-0.5`   |  0.0    | +0.5   |
| `unipolar-0.25`  |  0.0    | +0.25  |
| `unipolar-0.125` |  0.0    | +0.125 |
| `unipolar-0.2`   |  0.0    | +0.2   |
| `unipolar-0.1`   |  0.0    | +0.1   |
| `unipolar-0.078` |  0.0    | +0.078 |
| `unipolar-0.05`  |  0.0    | +0.05  |
| `unipolar-0.01`  |  0.0    | +0.01  |
| `unipolar-0.005` |  0.0    | +0.00  |

## in.input_mode (string: "single-ended" | "differential" | "pseudo-differential") {#node-config-node-uldaq-in-input_mode}

## in.signals (list of objects: signals) = () {#node-config-node-uldaq-in-signals}

## in.sample_rate (float) {#node-config-node-uldaq-in-sample_rate}

# Example {#node-type-uldaq-example}

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
