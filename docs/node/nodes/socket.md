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
    udp_node = {
        type = "socket"

        # Receive and sent 30 samples per message (combining)
        vectorize = 30

        # The maximum number of samples this node can receive
        samplelen = 10

        # By default, all nodes will have a few builtin hooks attached to them
        # When collecting statistics or measurements these are undesired
        builtin = false

        # Layer can be one of:
        #   - udp   Send / receive L4 UDP packets
        #   - ip    Send / receive L3 IP packets
        #   - eth   Send / receive L2 Ethernet frames (IEEE802.3)
        layer = "udp"


        format = "gtnet"

        in = {
            # This node only received messages on this IP:Port pair
            address = "127.0.0.1:12001"

            # Check if source address of incoming packets matches the remote address
            verify_source = true
        }

        out = {
            # This node sends outgoing messages to this IP:Port pair
            address = "127.0.0.1:12000"
        }
    }

    # Raw Ethernet frames
    ethernet_node = {
        type = "socket"

        layer = "eth"

        in = {
            address = "12:34:56:78:90:AB%lo:12002"
        }

        out = {
            address = "12:34:56:78:90:AB%lo:12002"
        }
    }

    # Datagram UNIX domain sockets require two endpoints
    unix_domain_node = {
        type = "socket"
        layer = "unix"

        in = {
            address = "/var/run/villas-node/node.sock"
        }

        out = {
            address = "/var/run/villas-node/client.sock"
        }
    }

    udp_multicast_node = {
        type = "socket"

        in = {
            # This node only received messages on this IP:Port pair
            address = "127.0.0.1:12001"

            # IGMP multicast is only support for layer = (ip|udp)
            multicast = {
                enabled = true

                # The multicast group. Must be within 224.0.0.0/4
                group = "224.1.2.3"

                # The IP address of the interface which should receive multicast packets
                interface = "1.2.3.4"

                # The time to live for outgoing multicast packets
                ttl = 128

                # Whether or not to loopback outgoing multicast packets to the local host
                loop = false
            }
        }

        out = {
            # This node sends outgoing messages to this IP:Port pair
            address = "127.0.0.1:12000"
        }
    }
}
```
