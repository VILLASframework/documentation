# Loopback {#node-type-loopback}

The @ref node-type-loopback node-type loops back every sample which has been sent to it.
Internally it is implemented by a FIFO queue.

It can be used to **chain multiple** @ref node-concept-path together by using the same @ref node-type-loopback node as an output node in the first path and as a source in the second path.

# Configuration {#node-config-loopback}

## queuelen (integer) {#node-config-loopback-queuelen}

The queue length of the internal queue which buffers the samples.

## samplelen (integer) {#node-config-loopback-samplelen}

The number of values each buffered sample can store.

## Example

```
nodes = {
	loopback_node = {
		type = "loopback",	# A loopback node will receive exactly the same data which has been sent to it.
					# The internal implementation is based on queue.

		queuelen = 1024		# The queue length of the internal queue which buffers the samples.
		samplelen = 64		# Each buffered sample can contain up to 64 values.
	}
}
```
