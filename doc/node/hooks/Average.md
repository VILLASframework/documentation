# Average signal values {#hook-type-average}

The `average` hook calculates arithmetic mean over a set of signals and insert it as a new value to the samples.

# Configuration {#node-config-hook-average}

## signals (list of signal names or signal indices) {#node-config-hook-average-signals}

## offset (integer) {#node-config-hook-average-offset}

The signal offset at which the average signal should be inserted.

## Example

@include node/etc/examples/hooks/average.conf
