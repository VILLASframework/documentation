# Loopback {#node-type-loopback}

The @ref node-type-loopback node-type loops back every sample which has been sent to it.
Internally it is implemented by a FIFO queue.

It can be used to **chain multiple** @ref node-concept-path together by using the same @ref node-type-loopback node as an output node in the first path and as a source in the second path.

# Prerequisites {#node-prereq-loopback}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-implementation-loopback}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/loopback.c

# Configuration {#node-config-node-loopback}

## queuelen (integer) {#node-config-node-loopback-queuelen}

The queue length of the internal queue which buffers the samples.

## samplelen (integer) {#node-config-node-loopback-samplelen}

The number of values each buffered sample can store.

## mode (string: "pthread" | "polling" | "pipe" | "eventfd" | "auto") = "auto" {#node-config-node-loopback-mode}

Specify the synchronization mode of the internal queue.

## Example

@include node/nodes/loopback.conf
