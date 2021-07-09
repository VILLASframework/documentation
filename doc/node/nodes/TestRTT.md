# Test Round-trip Time {#node-type-test-rtt}

The @ref node-type-test-rtt node-type is a virtual node-type which can be used to measure round-trip time to other nodes.
The `test_rtt` nodes periodically generate probes which must be looped back via a second node:

# Prerequisites {#node-type-test-prereq-rtt}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-type-test-implementation-rtt}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/test_rtt.cpp

# Configuration {#node-config-node-test-rtt}


# Configuration {#node-config-node-test-rtt}

## Example

@include node/etc/examples/nodes/test_rtt.conf
