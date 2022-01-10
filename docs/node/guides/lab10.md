---
sidebar_position: 10
---

# Lab 10: The daemon

During the previous labs, we use the `villas pipe`, `villas hook` and `villas signal` tools connect simulators and process the exchanged simulation data. This approach is handy for small tests, development and training.
However, more complex scenaries are unmanagable with this approach.

In this lab we introduce the VILLASnode daemon `villas node` which provides an easier way to setup complex scenarios.
In addition, `villas node` benefits from lower latencies because we omit the standard input / output streams and the conversion of the samples in a human readable / line-based representation.

**Note:** We recommend the usage of the daemon for all real-time critical HIL simulations

The invocation of the daemon is pretty simple.
Just pass the path to the configuration file as a paramteter:

```bash
villas node lab10_path_uni.conf
```

All VILLASnode tools can fetch their configuration file from remote locations (all [protocols from libcurl](https://curl.haxx.se/libcurl/c/CURLOPT_PROTOCOLS.html) are supported):

```bash
# From a web server
villas node https://villas.fein-aachen.org/doc/etc/lab3.conf

# From a Windows share (use single quotes!)
villas node 'smb://domain\user:passwd@example.com/share/file.conf'

# From a FTP server
villas node ftp://user:passwd@example.com/lab3.conf'

# Via SSH / SFTP
villas node sftp://user:passwd@example.com/etc/villas/node/lab3.conf
```

## Example configurations

All of the following examples use the same set of nodes, which we define in the file `lab10_nodes.conf`:

``` url="external/node/etc/labs/lab10_nodes.conf" title="Nodes for the following examples."
hugepages = 200

nodes = {
	# Node names can be any alphanumeric value
	rpi-1 = {
		type = "socket"
		layer = "udp"
		format = "gtnet" # pre-built format to communicate in RTDS GTNET-SKT payload

		in = {
			address = "*:12005" # villas node machine IP and port number

			signals = {
				count = 8
				type = "float"
			}

			hooks = (
				{
					type = "stats"
					warmup = 3000
				}
			)
		},
		out = {
			address = "192.168.0.5:12005" # remote machine IP and port number
		}
	},
	rpi-2 = {
		type = "socket"
		layer = "udp"
		format = "gtnet" # pre-built format to communicate in RTDS GTNET-SKT payload

		in = {
			address = "*:12006" # villas node machine IP and port number

			signals = {
				count = 8
				type = "float"
			}

			hooks = (
				{
					type = "stats"
					warmup = 3000
				}
			)
		}
		out = {
			address = "192.168.0.6:12006" # remote machine IP and port number
		}
	},
	rtds-1 = {
		type = "socket"
		layer = "udp"
		format = "gtnet"

		in = {
			address = "*:12083" # villas node machine IP and port number

			signals = {
				count = 8
				type = "float"
			}

			hooks = (
				{
					type = "stats"
					warmup = 3000
				}
			)
		}
		out = {
			address = "192.168.0.4:12083" # remote machine IP and port number
		}
	}
}
```

### A unidirectional path

**Todo:** Please note, that currently each node must only used once as an input node. Using the same node as an input to multiple paths is not possible. Please consider using @ref node-type-loopback nodes as a workaround.

The configuration file `lab10_uni_path.conf` extends `lab10_nodes.conf` with a path section.
This example reads samples from node `rpi-1` and forwards them immediately to node `rtds-1`.

``` url="external/node/etc/labs/lab10_path_uni.conf" title="node/etc/labs/lab10_path_uni.conf"
@include "lab10_nodes.conf"

paths = (
	{
		in  = [ "rpi-1"  ],
		out = [ "rtds-1" ]
	}
)
```

### A path with multiple destinations

A path can have multiple destinations by using an array for the `out` setting.
This example reads samples from node `rtds-1`, duplicates them and forwards them immediately to nodes `rpi-1` and `rpi-2`.

``` url="external/node/etc/labs/lab10_path_multiple_destinations.conf" title="node/etc/labs/lab10_path_multiple_destinations.conf"
@include "lab10_nodes.conf"

paths = (
	{
		in  = [ "rtds-1" ],
		out = [ "rpi-1", "rpi-2" ]
	}
)
```

### A path with a hook

Sometimes we want to filter and/or manipulate samples which are processes by a path.
To do so, we can attach __hook__ functions to a path.
These hook functions are called for every batch of samples which is processed by the pass.
This examples uses the `print` hook to display all forwarded samples on `stdout` of the console.

``` url="external/node/etc/labs/lab10_path_hook.conf" title="node/etc/labs/lab10_path_hook.conf"
@include "lab10_nodes.conf"

paths = (
	{
		in  = [ "rpi-1"  ],
		out = [ "rtds-1" ],

		hooks = (
			{ type = "print", output = "stdout" }
		)
	}
)
```

### A bidirectional path

In a last example we demonstrate a bi-directional path by using multiple entries in the `paths` section.

``` url="external/node/etc/labs/lab10_path_bidir.conf" title="node/etc/labs/lab10_path_bidir.conf"
@include "lab10_nodes.conf"

paths = (
	# Each path dictionary corresponds to one way communnication
	{
		in  = [ "rpi-1"  ],
		out = [ "rtds-1" ]
	},
	{
		in  = [ "rtds-1" ],
		out = [ "rpi-1"  ]
	}

	# Alternatively, you can use a single path specification
	#   and set reverse = true
	# Example:
	# {
	# 	in  = [ "rpi-1"  ],
	#	out = [ "rtds-1" ],
	#	reverse = true
	# }
)
```
