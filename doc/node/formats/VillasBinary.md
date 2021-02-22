# Custom VILLAS Binary {#node-format-villas-binary}

We designed a lightweight message format (or protocol) to facilitate a fast transmission with minimal (de-)serialization overhead.
The on-wire format of the network datagrams is not subject to a standardization process.

In constrast to the @ref node-format-villas-human format, this binary format is space efficient and commonly used for network communication.

Usually a a simulator sends one message per timestep.
A message contains a variable number of values.
Each message contains a header with the following fields:

 - 32 bit floating-point or integer values
 - 32 bit timestamp (integral seconds)
 - 32 bit timestamp (integral nanoseconds)
 - 16 bit sequence number
 - 4 bit version identifier

Timestamps are represented in [Unix time](https://en.wikipedia.org/wiki/Unix_time).

The format of the packets is described by the following code:

 - Datastructure: [struct msg](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/include/villas/formats/msg_format.h)
 - Code: [villas_binary_*()](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/formats/villas_binary.cpp) Functions

@image html msg_format.svg width=60%

For now, only the first message type (`data`) is used.
Therefore the complete protocol is **stateless**.
Later we might want to support more complex simulation scenarios which require some kind of controlling.

All values are sent in **network byte order** (big endian)!

@see msg for implementation details.

# Example

@image html wireshark_udp.png Wireshark capture of UDP traffic width=50%

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/villas_binary.cpp
