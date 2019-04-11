# Custom VILLAS Binary {#node-format-villas-binary}

Simulation data is sent in UDP (or IP, or Ethernet) packets over standard IP / Ethernet networks.
We designed a lightweight message format (or protocol) to facilitate a fast transmission.
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
