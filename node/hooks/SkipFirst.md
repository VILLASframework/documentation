# Skip First Samples {#hook-type-skip_first}

The `skip_first` hook discards the first samples of a simulation case.
It can either drop the first `n` samples or drop the first `n` seconds of a case.

# Configuration {#node-config-hook-skip_first}

The configuration consists of two options which are exclusive:

## samples (integer) {#node-config-hook-skip_first-samples}

## seconds (integer) {#node-config-hook-skip_first-seconds}

## Example

@include node/hooks/average.conf
