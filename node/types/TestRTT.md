# Test Round-trip Time {#node-type-test-rtt}

The @ref node-type-test-rtt node-type is a virtual node-type which can be used to measure round-trip time to other nodes.
The `test_rtt` nodes periodically generate probes which must be looped back via a second node:

# Implementation {#node-implementation-test-rtt}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/test_rtt.c


# Configuration {#node-config-test-rtt}

```conf
stats = 1

nodes = {
	remote = {
		type = "amqp";
		format = "json";

		uri = "amqp://localhost/";

		exchange = "reserve-test";
		routing_key = "test-key";
	},

	rtt = {
		type = "test_rtt";
		cooldown = 2;

		prefix = "poclab_test_rtt";
		format = "csv";
		cases = (
			{
				rates = 100;
				values = 5;
				limit = 1000;
			}
		)
	}
}

paths = (
	{
		in = "rtt";
		out = "remote";
		reverse = true;
	}
)
```

# Configuration {#node-config-test-rtt}

## Example

```conf
rtt_node = {					# The "test_rtt" node-type runs a set of test cases for varying
	type = "test_rtt",			# sending rates, number of values and generates statistics.
	cooldown = 2,				# The cooldown time between each test case in seconds

	prefix = "test_rtt",			# An optional prefix in the filename
	output = "/tmp/results/testA",		# The output directory for all results
						# The results of each test case will be written to a seperate file.
	format = "villas.human",		# The output format of the result files.

	cases = (				# The list of test cases
						# Each test case can specify a single or an array of rates and values
						# If arrays are used, we will generate multiple test cases with all
						# possible combinations
		{
			rates = 55.0,		# The sending rate in Hz
			values = 5,		# The number of values which should be send in each sample
			limit = 100		# The number of samples which should be send during this test case
		},
		{
			rates = [ 5, 10, 30 ],	# An array of rates in Hz
			values = [ 2, 10, 20 ],# An array of number of values
			duration = 5		# The duration of the test case in seconds (depending on the sending rate)
		}
	)
}
```
