# Test Round-trip Time {#node-type-test-rtt}

The `test_rtt` node-type is a virtual node-type which can be used to measure round-trip time to other nodes.
The `test_rtt` nodes periodically generate probes which must be looped back via a second node:

# Prerequisites {#node-type-test-rtt-prereq}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-type-test-rtt-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/test_rtt.cpp

# Configuration {#node-config-node-test-rtt}

@todo

# Example {#node-type-test-rtt-example}

@include node/etc/examples/nodes/test_rtt.conf
