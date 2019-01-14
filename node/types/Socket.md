# BSD Sockets {#node-type-socket}

The socket node-type is the most comprehensive and complex one.
It allows to send and receive simulation data over the network.
Internally it uses the well known [BSD socket API](https://en.wikipedia.org/wiki/Berkeley_sockets).

Please note that only datagram / packet, connection-less based network protocols are supported.
This means that there's currently no support for TCP!

The implementation supports multiple protocols / OSI layers:

 - Layer 1: Raw Ethernet Frames (no routing!)
 - Layer 2: Raw IP (internet / VPN routing possible)
 - Layer 3: UDP encapsulation

# Implementation {#node-implementation-socket}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/socket.c

# Configuration {#node-config-socket}

Every `socket` node supports the following special settings:

## format (string) {#node-config-socket-format}

The payload format which is used to encode and decode exchanged messages.

## local (string: "ip:port" | "mac:protocol") {#node-config-socket-local}

The local address and port number this node should listen for incoming packets.

Use `*` to listen on all interfaces: `local = "*:12000"`.

## remote (string: "ip:port" | "mac:protocol") {#node-config-socket-remote}

The address and port number of the remote endpoint of this node for outgoing packets.

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

## endian (string: "big" | "network" | "little") = "big" {#node-config-socket-endian}

This setting is only valid for the `none` and `fake` protocols.
If setting @ref node-config-socket-header is set to `villas`, the data is always interpreted in network (big) endianess.
It select the endianes which is used for outgoing and incoming data.

## verify_source (boolean) = false {#node-config-socket-verify_source}

Check if source address of incoming packets matches the remote address.

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

## multicast (dictionary) {#node-config-socket-multicast}

The @ref node-type-socket support sending and receiving IP / UDP packets to and from multicast addresses.

**Note:** Multicast is only supported by IPv4 addressing. Using these settings with `layer = eth` or IPv6 adresses will fail!

```
multicast = {				# IGMP multicast is only support for layer = (ip|udp)
	enabled		= true,

	group		= "224.1.2.3",	# The multicast group. Must be within 224.0.0.0/4
	interface	= "1.2.3.4",	# The IP address of the interface which should receive multicast packets.
	ttl		= 128,		# The time to live for outgoing multicast packets.
	loop		= false,	# Whether or not to loopback outgoing multicast packets to the local host.
}
```

## Example

```
udp_node = {					# The dictionary is indexed by the name of the node.
	type	= "socket",			# Type can be one of: socket, opal, file, gtfpga, ngsi
						# Start the server without arguments for a list of supported node types.

### The following settings are specific to the socket node-type!! ###

	layer	= "udp",			# Layer can be one of:
						#   udp                    Send / receive UDP packets
						#   ip                     Send / receive IP packets
						#   eth                    Send / receive raw Ethernet frames (IEEE802.3)

	header	= "gtnet-skt:fake",		# Header can be one of:
						#   default | villas       Use VILLASnode protocol (see struct msg) (default)
						#   none | gtnet-skt       Use no header, send raw data as used by RTDS GTNETv2-SKT
						#   fake | gtnet-skt:fake  Same as 'none', but use first three data values as
						#                             sequence, seconds & nanoseconds timestamp
						#                             In this mode values are uint32_t not floats!

	endian = "network",			# Endianess of header and data:
						#   big | network          Use big endianess. Also know as network byte order (default)
						#   little                 Use little endianess.

	verify_source = true, 			# Check if source address of incoming packets matches the remote address.

	local	= "127.0.0.1:12001",		# This node only received messages on this IP:Port pair
	remote	= "127.0.0.1:12000",		# This node sents outgoing messages to this IP:Port pair

	vectorize = 30,				# Receive and sent 30 samples per message (combining).

	netem = {				# Network emulation settings
						# Those settings can be specified for each node invidually!
		delay		= 100000,	# Additional latency in microseconds
		jitter		= 30000,	# Jitter in uS
		distribution	= "normal",	# Distribution of delay: uniform, normal, pareto, paretonormal
		loss		= 10		# Packet loss in percent
		duplicate	= 10,		# Duplication in percent
		corrupt 	= 10		# Corruption in percent
	}
}
```
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

@image html msg_format.svg width=60%

For now, only the first message type (`data`) is used.
Therefore the complete protocol is **stateless**.
Later we might want to support more complex simulation scenarios which require some kind of controlling.

Except for the simulation data, all values are sent in **network byte order** (big endian)!
The endianess of the simulation data is indicated by a single bit in the message header.
This allows us to reduce the amount of conversions during one transfer.

@see msg for implementation details.

## Example

@image html wireshark_udp.png Wireshark capture of UDP traffic width=50%

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

## Fix for Fedora

For some reason, Fedora installs the delay distribution profiles under `/usr/lib64/tc/`.
But libnl3 only seraches `/usr/lib/tc/`. This results in the following error when using netem:

```
Invalid delay distribution 'normal' in netem config in
```

To fix this error please add a symlink: `ln -s /usr/lib64/tc /usr/lib/tc`

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
