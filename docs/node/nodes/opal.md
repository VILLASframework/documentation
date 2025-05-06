---
hide_table_of_contents: true
---

# OPAL-RT Asynchronous Process

> In keeping with the design principle of openness, RT-LAB features can be extended through the use of Asynchronous User Applications also called Asynchronous Processes. This gives RT-LAB users access to the full power of the operating system and allow them to implement their own interfaces to various external devices. Although usually targeted for use with communication devices such as GPS receivers and power monitors, Asynchronous User Applications can be developed to interface acquisition boards, or implement system-specific software such as file management, etc.

(From [RT-LAB user documentation](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/144020065/Asynchronous+Processes))

They are used to exchange data between RT-LAB Simulink models and custom user-defined programs via [shared memory](https://en.wikipedia.org/wiki/Shared_memory) on a real-time target.

There are two ways to exchange sample values with an OPAL-RT simulator:

1. Use our adapted version of OPAL-RT's AsyncIP example for asynchronous processes (see [AsyncIP client](../clients/opal_async_ip.md))
    In this mode, OPAL will send sample data via UDP to VILLASnode. VILLASnode has to use the [`socket` node-type](socket.md).
2. Run VILLASnode as an asynchronous process itself. This is a highly experimental feature and implemented in the node-type `opal.async`.
    Data exchange is then handled using OPAL-RT's `libOpalAsyncApi`.
    This settings of this node-type a described on this page.

## Prerequisites

This node-types requires a running version of VILLASnode on an OPAL-RT target:

- An OPAL-RT target running OPAL-RT Linux v3.4.1 or newer
- RT-LAB v2023.1 or newer

:::caution
HYPERSIM or older targets running RHEL / CentOS operating systems are not supported.
:::

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/opal.cpp

## Installation

VILLASnode provides a dedicated Simulink library (`VILLASnode.slx`) to run VILLASnode in parallel to an RT-LAB model.
This library includes blocks to manage the configuration of VILLASnode and its lifecycle.
We have prepared an example RT-LAB project which uses this library and includes a little example to demonstrate its usage.

<figure align="center">
    <img alt="VILLASnode Simulink Library" src="/img/screenshots/node/opal-async/simulink_library.png" width="80%" />
    <figcaption>VILLASnode Simulink Library.</figcaption>
</figure>

<figure align="center">
    <img alt="RT-LAB Example Model" src="/img/screenshots/node/opal-async/example_model.png" width="80%" />
    <figcaption>RT-LAB Example Model.</figcaption>
</figure>

You can find the RT-LAB project as well as the Simulink library in the following location:
https://github.com/VILLASframework/node/tree/master/clients/opal/rtlab

## Configuration {#config}

When using the VILLASnode Simulink block, you can open and edit the VILLASnode configuration via your RT-LAB workstation:

<figure align="center">
    <img alt="VILLASnode Supernode Block Mask" src="/img/screenshots/node/opal-async/mask_supernode.png" width="30%" />
    <figcaption>VILLASnode Supernode Block Mask.</figcaption>
</figure>

<figure align="center">
    <img alt="VILLASnode Send Block Mask" src="/img/screenshots/node/opal-async/mask_send.png" width="30%" />
    <figcaption>VILLASnode Supernode Block Mask.</figcaption>
</figure>

<figure align="center">
    <img alt="VILLASnode Recv Block Mask" src="/img/screenshots/node/opal-async/mask_recv.png" width="30%" />
    <figcaption>VILLASnode Supernode Block Mask.</figcaption>
</figure>

During model load the configuration file will be loaded to the target and used by the VILLASnode asynchronous process.

### Reference

import ApiSchema from '@theme/ApiSchema';

{/* <ApiSchema id="node" example pointer="#/components/schemas/opal" /> */}

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
