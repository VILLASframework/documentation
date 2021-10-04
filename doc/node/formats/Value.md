# Single value text {#node-format-value}

The `value` format-type encodes a single sample value in a human readable representation.

**Note:** It currently only supports encoding of samples with a single signal!

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/value.cpp

# Configuration {#node-config-format-value}

The @ref node-format-value format-type supports all [generic format options](@ref node-config-format).

# Example Configuration {#node-format-value-example}

@include node/etc/examples/formats/value.conf
