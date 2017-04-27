# Berkely BSD Sockets {#socket}

The socket node-type is the most comprehensive and complex one.
It allows to send and receive simulation data over the network.
Internally it uses the well known BSD socket API.

Please note that only datagram / packet, connection-less based network protocols are supported.
This means that there's currently no support for TCP!

The implementation supports multiple protocols / OSI layers:

 - Layer 1: Raw Ethernet Frames (no routing!)
 - Layer 2: Raw IP (internet / VPN routing possible)
 - Layer 3: UDP encapsulation

## Configuration

Every `socket` node supports the following special settings:

#### `local` *("ip:port" | "mac:protocol")*

#### `remote` *("ip:port" | "mac:protocol")*

#### `netem` *(dictionary)*

Enables and configures the network emulation qeueing discipline.
See below for a more detailed description of this feature.

	netem = {				# Network emulation settings
						# Those settings can be specified for each node invidually!
		delay		= 100000,	# Additional latency in microseconds
		jitter		= 30000,	# Jitter in uS
		distribution	= "normal",	# Distribution of delay: uniform, normal, pareto, paretonormal
		loss		= 10		# Packet loss in percent
		duplicate	= 10,		# Duplication in percent
		corrupt 	= 10		# Corruption in percent
	}

#### `layer` *("udp" | "ip" | "eth")*

Select the network layer which should be used for the socket. Please note that `eth` can only be used locally in a LAN as it contains no routing information for the internet.

#### `header` *("default" | "none" | "fake")*

The socket node-type supports multiple protocols:

- The `default` VILLASnode header includes a couple of fields like the origin timestamp, number of values and the endianess of the transported data. The packet format is described in the following section called "Packet Format".
- It is also possible to just send raw data by omitting the header completely (`none`). Each value is expected to take 4 bytes. It can be either a single precission floating point number (`float`) or a 32 bit unsigned integer (`uint32_t`). This protocol is used by RTDS' GTNET-SKT card.
- The `fake` setting is very similar to the `none` setting. Only the first three values will have a special interpretation:
   - Sequence no. (`uint32_t`)
   - Timestamp seconds (Unix epoch, `uint32_t`)
   - Timestamp nano-seconds  (Unix epoch, `uint32_t`)

####  `endian` *("big" | "network" | "little")*

This setting is only valid for the `none` and `fake` protocols.
It select the endianes which is used for outgoing and incoming data.

### Example

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

## Packet Format

The on-wire format of the network packets is not subject to a standardization process.
It's a very simple packet-based format which includes:

 - 32bit floating-point or integer values
 - 32bit timestamp (integral seconds)
 - 32bit timestamp (integral nanoseconds)
 - 16bit sequence number
 - 4bit version identified
 - and several flags...

## Message

A message contains a variable number of values.
Usually a a simulator sends one message per timestep.

Simulation data is encapsulated in UDP packages in sent over IP networks like the internet.
We designed a lightweight message format (or protocol) to facilitate a fast transmission.

@diafile msg_format.dia

For now, only the first message type (`data`) is used.
Therefore the complete protocol is **stateless**.
Later we might want to support more complex simulation scenarios which require some kind of controlling.

Except for the simulation data, all values are sent in **network byte order** (big endian)!
The endianess of the simulation data is indicated by a single bit in the message header.
This allows us to reduce the amount of conversions during one transfer.

@see msg for implementation details.

### Example

@todo add screenshot of wireshark dump

## Network Emulation

VILLASnode supports the emulation of wide-area network characterisics.

This emulation can be configured on a per-node basis for **outgoing** (egress) data only.
Incoming data is not processed by the network emulation!

This network emulation is handled by Linux' [netem queuing discipline](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem) which is part of the traffic control subsystem.
Take a look at the following manual page for supported metrics: [tc-netem(8)](http://man7.org/linux/man-pages/man8/tc-netem.8.html).

VILLASnode only takes care of setup and initalizing the netem queuing discipline inside the kernel.
For this the iproute2 software package (`ip` & `tc` commands) must be installed.
The configuration is done via the config file.
Look at `etc/example.conf` for a section called `netem` or `tc-netem(8)` for more details.

### Custom delay distribution

Netem supports loading custom delay distributions.

1. Load and compile the netem tools from:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/netem
2. Create a custom distribution by following the steps described here:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.distribution
3. Put the generated distrubtion with the suffix `.dist` in the `tc` lib directory:  `/usr/lib/tc/`.
4. Load the distribution specifying the basename in the server config.

### Further information

 - https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.iproute2+tc
 - https://github.com/stv0g/netem

## GTNETv2 card with SKT protocol

The GTNETv2 card can be upgraded with SKT firmware to send/receive UDP and TCP packets over Ethernet.
The card operates the data in big endian format. Related draft files to run the tests are in the "clients/rtds/GTNETv2_SKT/" directory.
The data can be exchanged with VILLASnode using two methods. These are implemented as part of the socket node:
 - Without a header: Only data values are sent without any header information. It can be used using header = "gtnet-skt:fake" in config file.
 - With a header: First 3 values are sequence, timestamp sec and timesatmp nanosec. Timestamp can be added using GTSYNC card (GPS source) in the draft file or if no timestamp is present (value set to 0), VILLASnode will add its own timestamp (NTP source) replacing the 0 value.
 
### Common Problems
Problems faced during setting up of GT-SKT card with GTSYNC card are:
 - The GT-SKT card was not detected in the RSCAD config manager because the GPC processor port was faulty. Shifting the GT-SKT card to another port solved the issue. Also check the fiber cable if that is faulty.
 - The GT-SKT display should display the correct processor number and the protocol version. Use the SEL button to toggle between processor and protocol display. The processor value should be of the form i.e. 3.1 (processor 3 GT port 1) and the protocol should be 15 which is GT-SKT. If the protocol is 16 there is an error. Also processor number 0.0 means the GT-SKT card can’t detect the processor.
 - Check that GTWIF Firmware version is 4.104 build 7 or higher and RSCAD version is 4.003.1 or higher.
 - In case the GT-SKT can’t detect the processor, restart the rack after repeating step 1. In case GT-SKT can’t detect a correct protocol, telnet (login: rtds, password: commcard) into the card and run the command “status” to see which protocol version the card has. If the card doesn’t display the correct protocol in the telnet but the “Firmware Upgrade” in RSCAD shows the correct version, downgrade the version in Firmware upgrade and then upgrade it to the desired version.
 - In case the draft file gives an error “Timing source not synced”, the GTSYNC card is not connected to GPS source.
