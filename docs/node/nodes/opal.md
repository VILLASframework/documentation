---
hide_table_of_contents: true
---

# OPAL-RT Asynchronous Process

The communication between OPAL-RT models and VILLASnode is established by using asynchronous programs.
Asynchronous programs are are a feature of RT-LAB. They are used to exchange data between Simulink models and custom C programs.

There are two ways to exchange sample values with an OPAL-RT simulator:

1. Use our adapted version of OPAL-RT's AsyncIP example for asynchronous processes (see [AsyncIP client](../clients/async_ip.md))
    In this mode, OPAL will send sample data via UDP to VILLASnode. VILLASnode has to use the [`socket` node-type](socket.md).
2. Run VILLASnode as an asynchronous process itself. This is a highly experimental feature and implemented in the node-type `opal`.
    It requires a 32-bit version of the `villas-node`. Data exchange is then handled using OPAL-RT's libOpalAsyncApi.
    This settings of this node-type a described on this page.

## Prerequisites

This node-type requires [libOpal{AsyncApi,Core,Utils}](https://git.rwth-aachen.de/acs/public/villas/libopal).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/opal.cpp

## Configuration {#config}

Every `opal` node supports the following special settings:

### send_id (integer)

### recv_id (integer)

### reply (boolean)

## Example

``` url="external/node/etc/examples/nodes/opal.conf" title="node/etc/examples/nodes/opal.conf"
nodes = {
	opal_node = {					# The server can be started as an Asynchronous process
		type	= "opal",			# from within an OPAL-RT model.

	### The following settings are specific to the opal node-type!! ###

		send_id	= 1,				# It's possible to have multiple send / recv Icons per model
		recv_id	= 1,				# Specify the ID here.
		reply = true
	},
	file_node = {
		type	= "file",

	### The following settings are specific to the file node-type!! ###

		uri = "logs/input.log",			# These options specify the path prefix where the the files are stored
		
		in = {
			epoch_mode = "direct"		# One of: direct (default), wait, relative, absolute
			epoch = 10			# The interpretation of this value depends on epoch_mode (default is 0).
							# Consult the documentation of a full explanation

			rate = 2.0			# A constant rate at which the lines of the input files should be read
							# A missing or zero value will use the timestamp in the first column
							# of the file to determine the pause between consecutive lines.
			
			buffer_size = 1000000

			eof = "rewind"	# One of: rewind, exit (default) or wait
		},
		out = {
			flush = true
			buffer_size = 1000000
		}
	}
}
```

## Arguments for OPAL-RT block

RT-LAB already provides a block to establish simple TCP/IP communication: ???
This block is based on a more generic block used for asynchronous programs: ???

:::note ToDo
Insert name of RT-LAB blocks.
:::

| Param		 | Description   | Example Value  |
| :------------- | :------------ |:-------------- |
| FloatParam[0]	 | Protocol      |                |
| FloatParam[1]  | RemotePort    | 10200          |
| FloatParam[2]  | LocalPort	 | 10201          |
| StringParam[0] | RemoteAddr	 | 192.168.0.10   |
| StringParam[1] | LocalAddr	 | 192.168.0.11   |
| StringParam[2] | InterfaceName | eth2           |

:::note ToDo
Complete documentation for the OPAL-RT Simulink module.
:::
