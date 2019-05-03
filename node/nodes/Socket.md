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

For information see also: @ref node-netem

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
@include node/etc/examples/node/nodes/udp.conf

### Ethernet layer
@include node/etc/examples/nodes/ethernet.conf

### Receive multicast traffic
@include node/etc/examples/nodes/multicast.conf
