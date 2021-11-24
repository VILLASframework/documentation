# TEMPer / PCsensor temperature sensors {#node-type-temper}

The `temper` node-type reads out temperature and humidity measurements from TEMPer USB senors.
These sensors are sold by [PCsenser](http://www.pcsensor.com/temperature-humidity-series.html).

The implementation is tested against the following products:

- TEMPer2* eg. TEMPer2V1.3 (VID/PID `0x0c45`/`0x7401`)
- TEMPerV1.4 (VID/PID `0x0c45`/`0x7401`)
- TEMPerHUM (VID/PID `0x0c45`/`0x7402`)

# Prerequisites {#node-type-temper-prereq}

This node-type requires [libusb](https://libusb.info/) (>= 1.0.23).

# Implementation {#node-type-temper-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/temper.cpp

# Configuration {#node-config-node-temper}

## calibration.scale (double) = 1.0 {#node-config-node-temper-scale}

A scaling factor for calibrating the sensor.

## calibration.offset (double) = 0.0  {#node-config-node-temper-calibration-offset}

An offset for calibrating the sensor.

## bus (integer) {#node-config-node-temper-bus}

A filter applied to the USB bus number for selecting a specific sensor if multiple are available.

## port (integer) {#node-config-node-temper-port}

A filter applied to the USB port number for selecting a specific sensor if multiple are available.

# Example {#node-type-temper-example}

@include node/etc/examples/nodes/temper.conf
