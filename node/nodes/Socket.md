# Sockets {#node-type-socket}

The socket node-type is the most comprehensive and complex one.
It allows to send and receive simulation data over the network.
Internally it uses the well known [BSD socket API](https://en.wikipedia.org/wiki/Berkeley_sockets).

Please note that only datagram / packet, connection-less based network protocols are supported.
This means that there's currently no support for TCP!

The implementation supports multiple protocols / OSI layers:

 - Layer 1: Raw Ethernet Frames (no routing!)
 - Layer 2: Raw IP (internet / VPN routing possible)
 - Layer 3: UDP encapsulation

# Prerequisites {#node-prereq-socket}

This node-type does not have any special library dependencies. It is always available.

Optionally, [libnl3](http://www.infradead.org/~tgr/libnl/) is used to setup network emulation as described in section @ref node-type-socket-netem.

# Implementation {#node-implementation-socket}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/socket.c

# Configuration {#node-config-node-socket}

Every `socket` node supports the following special settings:

## format (string: "csv" | "json" | "villas.human" | "raw" | ...) {#node-config-node-socket-format}

The payload format which is used to encode and decode exchanged messages.

See: @ref node-formats

## in.address (string: "ip:port" | "mac:protocol") {#node-config-node-socket-in-address}

The local address and port number this node should listen for incoming packets.

Use `*` to listen on all interfaces: `local = "*:12000"`.

## out.address (string: "ip:port" | "mac:protocol") {#node-config-node-socket-out-address}

The remote address and port number to which this node will send data.

## layer (string: "udp" | "ip" | "eth") {#node-config-node-socket-layer}

Select the network layer which should be used for the socket. Please note that `eth` can only be used locally in a LAN as it contains no routing information for the internet.

## verify_source (boolean) = false {#node-config-node-socket-verify_source}

Check if source address of incoming packets matches the remote address.

## out.netem (dictionary) {#node-config-node-socket-out-netem}

Enables and configures the network emulation qeueing discipline.

See: @ref node-config-node-netem

## in.multicast (dictionary) {#node-config-node-socket-in-multicast}

The @ref node-type-socket support sending and receiving IP / UDP packets to and from multicast addresses.

**Note:** Multicast is only supported by IPv4 addressing. Using these settings with `layer = eth` or IPv6 adresses will fail!

## in.multicast.enabled (boolean) = true {#node-config-node-socket-multicast-enabled}

Weather or not multicast group subscription is active.

## in.multicast.group (string: IPv4 Address) {#node-config-node-socket-multicast-group}

The multicast group. Must be within 224.0.0.0/4

## in.multicast.interface (string: IPv4 Address) {#node-config-node-socket-multicast-interface}

The IP address of the interface which should receive multicast packets.

## in.multicast.ttl (integer) {#node-config-node-socket-multicast-ttl}

The time to live for outgoing multicast packets.

## in.multicast.loop (boolean) {#node-config-node-socket-multicast-loop}

## Example

### UDP layer
@include node/nodes/udp.conf

### Ethernet layer
@include node/nodes/ethernet.conf

### Network Emulation (netem)
@include node/nodes/netem.conf

### Receive multicast traffic
@include node/nodes/multicast.conf

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
