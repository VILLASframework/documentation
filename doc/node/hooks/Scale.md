# Scale and offset signals {#node-hook-type-scale}

The `scale` hook modifies sample signals by a gain factor and optionally ads an offset.
First the original signal value is multiplied by the gain, then the offset is added.

# Implementation {#node-hook-type-scale-implementation}

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/scale.cpp

# Configuration {#node-config-hook-scale}

## signal (string) {#node-config-hook-scale-signal}

The name of the signal which should be scaled.

## offset (float) = 0.0 {#node-config-hook-scale-offset}

The offset which is added to the signal after gain.

## gain (float) = 1.0 {#node-config-hook-scale-gain}

The gain which is mulitplied to the signal before the offset is added.

# Example {#node-hook-type-scale-example}

@include node/etc/examples/hooks/scale.conf
