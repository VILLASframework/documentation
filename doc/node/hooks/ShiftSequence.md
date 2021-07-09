# Shift sequence numbers {#node-hook-type-shift_seq}

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/shift_seq.cpp

# Configuration {#node-config-hook-shift_seq}

## offset (integer) {#node-config-hook-shift_seq-offset}

The offset which is added to the sequence number of each processed sample.

## Example

@include node/etc/examples/hooks/shift_seq.conf
