---
hide_table_of_contents: true
---

# Sockets

The socket node-type is the most comprehensive and complex one.
It allows to send and receive simulation data over the network.
Internally it uses the well known [BSD socket API](https://en.wikipedia.org/wiki/Berkeley_sockets).

Please note that only datagram / packet, connection-less based network protocols are supported.
This means that there's currently no support for TCP!

The implementation supports multiple protocols / OSI layers:

 - **Layer 1:** Raw Ethernet Frames (no routing!)
 - **Layer 2:** Raw IP (internet / VPN routing possible)
 - **Layer 3:** UDP encapsulation

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

Optionally, [libnl3](http://www.infradead.org/~tgr/libnl/) is used to setup network emulation as described in page [Netem Emulation](../netem.md).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/socket.cpp

## Configuration {#config}

Every `socket` node supports the following special settings:

### format (string: "csv" | "json" | "villas.human" | "raw" | ...)

The payload format which is used to encode and decode exchanged messages.

See: [Format Types](../formats/index.md)

### in.address (string: "ip:port" | "mac:protocol")

The local address and port number this node should listen for incoming packets.

Use `*` to listen on all interfaces: `local = "*:12000"`.

### out.address (string: "ip:port" | "mac:protocol")

The remote address and port number to which this node will send data.

### layer (string: "udp" | "ip" | "eth") = "udp"

Select the network layer which should be used for the socket. Please note that `eth` can only be used locally in a LAN as it contains no routing information for the internet.

### verify_source (boolean) = false

Check if source address of incoming packets matches the remote address.

### out.netem (dictionary)

Enables and configures the network emulation queuing discipline.

For information see also: [Netem emulation](../netem.md)

### in.multicast (dictionary)

The `socket` node-type supports sending and receiving IP / UDP packets to and from multicast addresses.

**Note:** Multicast is only supported by IPv4 addressing. Using these settings with `layer = eth` or IPv6 addresses will fail!

### in.multicast.enabled (boolean) = true

Weather or not multicast group subscription is active.

### in.multicast.group (string: IPv4 Address)

The multicast group. Must be within 224.0.0.0/4

### in.multicast.interface (string: IPv4 Address)

The IP address of the interface which should receive multicast packets.

### in.multicast.ttl (integer)

The time to live for outgoing multicast packets.

### in.multicast.loop (boolean)

## Example

``` url="external/node/etc/examples/nodes/socket.conf" title="node/etc/examples/nodes/socket.conf"
nodes = {
	udp_node = {					# The dictionary is indexed by the name of the node.
		type = "socket",			# For a list of available node-types run: 'villas-node -h'
		vectorize = 30,				# Receive and sent 30 samples per message (combining).
		samplelen = 10				# The maximum number of samples this node can receive

		builtin = false,			# By default, all nodes will have a few builtin hooks attached to them.
									# When collecting statistics or measurements these are undesired.

	### The following settings are specific to the socket node-type!! ###

		layer	= "udp",			# Layer can be one of:
							#   - udp	 Send / receive L4 UDP packets
							#   - ip	  Send / receive L3 IP packets
							#   - eth	 Send / receive L2 Ethernet frames (IEEE802.3)

		format	= "gtnet",			# For a list of available node-types run: 'villas-node -h'

		in = {
			address = "127.0.0.1:12001"	# This node only received messages on this IP:Port pair
			
			verify_source = true 		# Check if source address of incoming packets matches the remote address.
		},
		out = {
			address = "127.0.0.1:12000",	# This node sends outgoing messages to this IP:Port pair
		}
	}

	ethernet_node = {
		type	= "socket",			# See above.

	### The following settings are specific to the socket node-type!! ###

		layer	= "eth",
		in = {
			address	= "12:34:56:78:90:AB%lo:12002"
		},
		out = {
			address = "12:34:56:78:90:AB%lo:12002"
		}	
	},

	unix_domain_node = {
		type	= "socket",
		layer	= "unix",			# Datagram UNIX domain sockets require two endpoints
		
		in = {
			address = "/var/run/villas-node/node.sock"
		},
		out = {
			address	= "/var/run/villas-node/client.sock"
		}
	}

	udp_multicast_node = {					# The dictionary is indexed by the name of the node.
		type = "socket",			# For a list of available node-types run: 'villas-node -h'

	### The following settings are specific to the socket node-type!! ###

		in = {
			address = "127.0.0.1:12001"	# This node only received messages on this IP:Port pair

			multicast = {			# IGMP multicast is only support for layer = (ip|udp)
				enabled	= true,

				group = "224.1.2.3",	# The multicast group. Must be within 224.0.0.0/4
				interface = "1.2.3.4",	# The IP address of the interface which should receive multicast packets.
				ttl = 128,		# The time to live for outgoing multicast packets.
				loop = false,		# Whether or not to loopback outgoing multicast packets to the local host.
			}
		},
		out = {
			address = "127.0.0.1:12000",	# This node sends outgoing messages to this IP:Port pair
		}
	}
}
```
