# Average signal values {#node-hook-type-average}

The `average` hook calculates arithmetic mean over a set of signals and insert it as a new value to the samples.

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/average.cpp

# Configuration {#node-config-hook-average}

## signals (list of signal names or signal indices) {#node-config-hook-average-signals}

## offset (integer) {#node-config-hook-average-offset}

The signal offset at which the average signal should be inserted.

## Example

@include node/etc/examples/hooks/average.conf
