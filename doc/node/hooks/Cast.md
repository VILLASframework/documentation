# Cast signal values {#node-hook-type-cast}

The `cast` hook casts the data-type of signals and can set a new name and unit to the casted signal.

# Implementation {#node-hook-type-cast-implementation}

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/cast.cpp

# Configuration {#node-config-hook-cast}

## signal (integer or string: signal name or index) {#node-config-hook-cast-signal}

## new_type (string: "integer" | "float" | "boolean" | "complex" ) {#node-config-hook-cast-new_type}

The the type of the casted signal.

## new_name (string) {#node-config-hook-cast-new_name}

## new_type (string) {#node-config-hook-cast-new_type}

# Example {#node-hook-type-cast-implementation}

@include node/etc/examples/hooks/cast.conf
