# Scale and offset signals {#hook-type-scale}

The `scale` hook modifies sample signals by a gain factor and optionally ads an offset.
First the original signal value is multiplied by the gain, then the offset is added.

# Configuration {#node-config-hook-scale}

## offset (float) = 0.0 {#node-config-hook-scale-offset}

The offset which is added to the signal after gain.

## gain (float) = 1.0 {#node-config-hook-scale-gain}

The gain which is mulitplied to the signal before the offset is added.

## Example

@include node/hooks/scale.conf
