---
sidebar_label: TEMPer
hide_table_of_contents: true
---

# TEMPer / PCsensor temperature sensors

The `temper` node-type reads out temperature and humidity measurements from TEMPer USB senors.
These sensors are sold by [PCsenser](http://www.pcsensor.com/temperature-humidity-series.html).

The implementation is tested against the following products:

- TEMPer2* eg. TEMPer2V1.3 (VID/PID `0x0c45`/`0x7401`)
- TEMPerV1.4 (VID/PID `0x0c45`/`0x7401`)
- TEMPerHUM (VID/PID `0x0c45`/`0x7402`)

## Prerequisites

This node-type requires [libusb](https://libusb.info/) (>= 1.0.23).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/temper.cpp

## Configuration {#config}

### calibration.scale (double) = 1.0

A scaling factor for calibrating the sensor.

### calibration.offset (double) = 0.0 

An offset for calibrating the sensor.

### bus (integer)

A filter applied to the USB bus number for selecting a specific sensor if multiple are available.

### port (integer)

A filter applied to the USB port number for selecting a specific sensor if multiple are available.

## Example

``` url="external/node/etc/examples/nodes/temper.conf" title="node/etc/examples/nodes/temper.conf"
nodes = {
	temper_node = {
		type = "temper"

		calibration = {
			scale = 1.0
			offset = 0.0
		}

		bus = 0x1
		port = 0x1
	}
}
```
