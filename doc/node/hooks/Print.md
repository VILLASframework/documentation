# Print sample data {#hook-type-print}

The `print` hook prints processed samples to the standard output or into a file.
While doing so, it supports all the formats described here: @ref node-formats .
It can also optionally prefix each line of output with a user definable prefix in order to distinguish the output of multiple `print` hooks.

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/print.cpp

# Configuration {#node-config-hook-print}

## format (string: format type) {#node-config-hook-print-format}

## output (string) {#node-config-hook-print-output}

## prefix (string) {#node-config-hook-print-prefix}

## Example

@include node/etc/examples/hooks/print.conf
