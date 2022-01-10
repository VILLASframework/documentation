# Comedi {#node-type-comedi}

# Prerequisites {#node-type-comedi-prereq}

This node-type requires [comedilib](http://comedi.org) (>= 0.11.0).

# Implementation {#node-type-comedi-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/comedi.cpp

# Configuration {#node-config-node-comedi}

@todo Document config options for Comedi node-type

# Example {#node-type-comedi-example}

``` url="external/node/etc/examples/nodes/comedi.conf" title="node/etc/examples/nodes/comedi.conf"
nodes = {
	pcie6259 = {
		type = "comedi",

		device = "/dev/comedi0",
		in = {
			subdevice = 0,
			rate = 1000,
			
			signals = (
				# note: order in this array defines order in villas sample
				{ channel = 0, range = 0, aref = 0, name = "temperature_int" },
				{ channel = 1, range = 0, aref = 0, name = "loopback_ao0" },
				{ channel = 2, range = 0, aref = 0, name = "loopback_ao1" },
				{ channel = 3, range = 0, aref = 0, name = "bnc_ext" }
			)
		},
		out = {
			subdevice = 1,
			# Note: buffer size and rate shouldn't be changed at the moment
			# output sample rate
			rate = 40000,
			# comedi write buffer in kilobytes
			bufsize = 24,
			
			signals = (
				# note: order in this array corresponds to order in villas sample
				{ name = "ao0", channel = 0, range = 0, aref = 0 },
				{ name = "ao1", channel = 1, range = 0, aref = 0 },
				{ name = "ao2", channel = 2, range = 0, aref = 0 },
				{ name = "ao3", channel = 3, range = 0, aref = 0 }
			)
		}
	},

	remote = {
		type = "socket",
		layer = "udp"
		format = "protobuf",
		
		in = {
			address = "*:12000"
		},
		out = {
			address = "134.130.169.32:12000"
		}
	},

	sine1 = {
		type = "signal",
		signal = "sine",
		values = 1,
		frequency = 50,
		rate = 10000,
	},

	sine2 = {
		type = "signal",
		signal = "sine",
		values = 1,
		frequency = 100,
		rate = 10000,
	}
}

paths = (
	# 2-ch sine
	# {
	# 	in = [ "sine1.data[0]", "sine2.data[0]" ]
	# 	out = "pcie6259"
	# 	rate = 10000
	# 	mask = ()
	# }

	# Remote data via UDP
	{
		in = "remote.data[0-3]"
		out = "pcie6259"
		rate = 40000
		mask = ()
	}
)
```

# Further reading

## Linux Control and measurement device interface

> [The Comedi project](http://comedi.org) develops open-source drivers, tools, and libraries for data acquisition.
