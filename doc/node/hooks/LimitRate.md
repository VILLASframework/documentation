# Limit rate {#hook-type-limit_rate}

The `limit_rate` hook discards samples in order to limit the sample rate to a certain rate.
The decission whether a sample is discarded or not is based on its timestamp.

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/limit_rate.cpp

# Configuration {#node-config-hook-limit_rate}

## rate (float) {#node-config-hook-limit_rate-rate}

## Example

@include node/etc/examples/hooks/limit_rate.conf
