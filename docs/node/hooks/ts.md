# Timestamp {#node-hook-type-ts}

The `ts` hook overwrite the origin timestamp field of each sample with the current system time.

# Implementation {#node-hook-type-ts-implementation}

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/ts.cpp

# Configuration {#node-config-hook-ts}

The `ts` hook has no configurable options.

# Example {#node-hook-type-ts-example}

@include node/etc/examples/hooks/ts.conf
