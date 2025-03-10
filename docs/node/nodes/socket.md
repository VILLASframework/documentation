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

 - **Data-Link Layer 2:** Raw Ethernet Frames (no routing!)
 - **Network Layer 3:** Raw IP (internet / VPN routing possible)
 - **Transport Layer 4:** UDP encapsulation, TCP client or server

## Prerequisites

This node-type does not have any special library dependencies. It is always available.

Optionally, [libnl3](http://www.infradead.org/~tgr/libnl/) is used to setup network emulation as described in page [Netem Emulation](../netem.md).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/socket.cpp

## Configuration {#config}

For TCP connection, the node can only be either server or client which is specified by "tcp-server" or "tcp-client" in the layer section.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/socket" />

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
							#	- tcp-server Send / receive byte stream as a TCP client
							#	- tcp-client Send / receive byte stream as a TCP server

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

	tcp_server_node = {					# The dictionary is indexed by the name of the node.
		type = "socket",				# For a list of available node-types run: 'villas-node -h'

	### The following settings are specific to the socket node-type!! ###

		layer	= "tcp-server",			# see above
		in = {
			address = "127.0.0.1:12001"	# TCP server address
										# This node only sends and received messages with its client
			
		},
		out = {
			address = "127.0.0.1:12000",	
		}
	}

	tcp_client_node = {					# The dictionary is indexed by the name of the node.
		type = "socket",				# For a list of available node-types run: 'villas-node -h'

	### The following settings are specific to the socket node-type!! ###

		layer	= "tcp-client",				# See above
		in = {
			address = "127.0.0.1:12001"	
		},
		out = {
			address = "127.0.0.1:12000",	# This node connect to TCP server on this IP:Port pair
											# This node only sends and receive messages with its server
		}
	}
}
```
