# Berkely BSD Sockets {#node-type-socket}

The socket node-type is the most comprehensive and complex one.
It allows to send and receive simulation data over the network.
Internally it uses the well known BSD socket API.

Please note that only datagram / packet, connection-less based network protocols are supported.
This means that there's currently no support for TCP!

The implementation supports multiple protocols / OSI layers:

 - Layer 1: Raw Ethernet Frames (no routing!)
 - Layer 2: Raw IP (internet / VPN routing possible)
 - Layer 3: UDP encapsulation

# Configuration {#node-config-socket}

Every `socket` node supports the following special settings:

## local ("ip:port" | "mac:protocol") {#node-config-socket-local}

The local address and port number this node should listen for incoming packets.

Use `*` to listen on all interfaces: `local = "*:12000"`.

## remote (string: "ip:port" | "mac:protocol") {#node-config-socket-remote}

The address and port number of the remote endpoint of this node for outgoing packets.

## netem (dictionary) {#node-config-socket-netem}

Enables and configures the network emulation qeueing discipline.
See below for a more detailed description of this feature.

```
netem = {				# Network emulation settings
					# Those settings can be specified for each node invidually!
	delay		= 100000,	# Additional latency in microseconds
	jitter		= 30000,	# Jitter in uS
	distribution	= "normal",	# Distribution of delay: uniform, normal, pareto, paretonormal
	loss		= 10		# Packet loss in percent
	duplicate	= 10,		# Duplication in percent
	corrupt 	= 10		# Corruption in percent
}
```

## layer (string: "udp" | "ip" | "eth") {#node-config-socket-layer}

Select the network layer which should be used for the socket. Please note that `eth` can only be used locally in a LAN as it contains no routing information for the internet.

## header (string: "villas" | "default" | "gtnet-skt" | "none" | "gtnet-skt:fake" | "fake") = "villas" {#node-config-socket-header}

The socket node-type supports multiple protocols:

| Value			| Description |
| :--			| :-- |
| `villas`		| The standard VILLASnode header includes a couple of fields like the origin timestamp and the number of values of the transmitted data. The packet format is described in section @ref node-type-socket-format. |
| `gtnet-skt` / `none`	| It is also possible to just send raw data by omitting the header completely (`none`). Each value is expected to take 4 bytes. It can be either a single precission floating point number (`float`) or a 32 bit unsigned integer (`uint32_t`). This protocol is used by @ref node-client-gtnet. |
| `gtnet-skt:fake` / `fake`	| The `fake` setting is very similar to the `none` setting. See below for details. |

Only the first three values will have a special interpretation:
   - Sequence no. (`uint32_t`)
   - Timestamp seconds ([Unix time](https://en.wikipedia.org/wiki/Unix_time), `uint32_t`)
   - Timestamp nano-seconds  ([Unix time](https://en.wikipedia.org/wiki/Unix_time), `uint32_t`)

## endian ("big" | "network" | "little") = "big" {#node-config-socket-endian}

This setting is only valid for the `none` and `fake` protocols.
If setting @ref node-config-socket-header is set to `villas`, the data is always interpreted in network (big) endianess.
It select the endianes which is used for outgoing and incoming data.

## Example

	nodes = {
		udp_node = {					# The dictionary is indexed by the name of the node.
			type	= "socket",			# Type can be one of: socket, opal, file, gtfpga, ngsi
								# Start the server without arguments for a list of supported node types.
		
		### The following settings are specific to the socket node-type!! ###
	
			layer	= "udp"				# Layer can be one of:
								#   udp		Send / recv UDP packets
								#   ip		Send / recv IP packets
								#   eth		Send / recv raw Ethernet frames (IEEE802.3)
	
			header	= "gtnet-skt:fake",		# Header can be one of:
								#   default | villas       Use VILLASnode protocol (see struct msg) (default)
								#   none | gtnet-skt       Use no header, send raw data as used by RTDS GTNETv2-SKT
								#   fake | gtnet-skt:fake  Same as 'none', but use first three data values as
								#                             sequence, seconds & nanoseconds timestamp
								#                             In this mode values are uint32_t not floats!
								
			endian = "network",			# Endianess of header and data:
								#   big | network          Use big endianess. Also know as network byte order (default)
								#   little                 Use little endianess.
								
			local	= "127.0.0.1:12001",		# This node only received messages on this IP:Port pair
			remote	= "127.0.0.1:12000"		# This node sents outgoing messages to this IP:Port pair
		
			vectorize = 30				# Receive and sent 30 samples per message (multiplexing).
		}
	}

# Packet Format {#node-type-socket-format}

Simulation data is sent in UDP (or IP, or Ethernet) packets over standard IP / Ethernet networks.
We designed a lightweight message format (or protocol) to facilitate a fast transmission.
The on-wire format of the network datagrams is not subject to a standardization process.

Usually a a simulator sends one message per timestep.
A message contains a variable number of values.
Each message contains a header with the following fields:

 - 32 bit floating-point or integer values
 - 32 bit timestamp (integral seconds)
 - 32 bit timestamp (integral nanoseconds)
 - 16 bit sequence number
 - 4 bit version identifier
 
 Timestamps are represented in [Unix time](https://en.wikipedia.org/wiki/Unix_time).

@image html msg_format.svg width=75%

For now, only the first message type (`data`) is used.
Therefore the complete protocol is **stateless**.
Later we might want to support more complex simulation scenarios which require some kind of controlling.

Except for the simulation data, all values are sent in **network byte order** (big endian)!
The endianess of the simulation data is indicated by a single bit in the message header.
This allows us to reduce the amount of conversions during one transfer.

@see msg for implementation details.

## Example

@todo add screenshot of wireshark dump

# Network Emulation {#node-type-socket-netem}

VILLASnode supports the emulation of wide-area network characterisics.

This emulation can be configured on a per-node basis for **outgoing** (egress) data only.
Incoming data is not processed by the network emulation!

This network emulation is handled by Linux' [netem queuing discipline](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem) which is part of the traffic control subsystem.
Take a look at the following manual page for supported metrics: [tc-netem(8)](http://man7.org/linux/man-pages/man8/tc-netem.8.html).

VILLASnode only takes care of setup and initalizing the netem queuing discipline inside the kernel.
For this the iproute2 software package (`ip` & `tc` commands) must be installed.
The configuration is done via the config file.
Look at `etc/example.conf` for a section called `netem` or `tc-netem(8)` for more details.

## Custom delay distribution

Netem supports loading custom delay distributions.

1. Load and compile the netem tools from:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/netem
2. Create a custom distribution by following the steps described here:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.distribution
3. Put the generated distrubtion with the suffix `.dist` in the `tc` lib directory:  `/usr/lib/tc/`.
4. Load the distribution specifying the basename in the server config.

## Further information

 - https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.iproute2+tc
 - https://github.com/stv0g/netem