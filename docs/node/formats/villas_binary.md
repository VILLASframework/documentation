---
hide_table_of_contents: true
---

# Custom VILLAS Binary

We designed a lightweight message format (or protocol) to facilitate a fast transmission with minimal (de-)serialization overhead.
The on-wire format of the network datagrams is not subject to a standardization process.

In contrast to the [`villas.human` format](villas_human.md), this binary format is space efficient and commonly used for network communication.

Usually a a simulator sends one message per timestep.
A message contains a variable number of values.
Each message contains a header with the following fields:

 - 32 bit floating-point or integer values
 - 32 bit timestamp (integral seconds)
 - 32 bit timestamp (integral nanoseconds)
 - 16 bit sequence number
 - 4 bit version identifier

Timestamps are represented in [Unix time](https://en.wikipedia.org/wiki/Unix_time).

The format of the packets is described by the following code [`struct Message`](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/include/villas/formats/msg_format.hpp) structure.

<figure align="center">
    <img alt="VILLAS binary payload format" src="/img/drawio/msg_format.svg" width="80%" />
    <figcaption>VILLAS binary payload format.</figcaption>
</figure>

For now, only the first message type (`data`) is used.
Therefore the complete protocol is **stateless**.
Later we might want to support more complex simulation scenarios which require some kind of controlling.

All values are sent in **network byte order** (big endian)!

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/villas_binary.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/villas_binary" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/villas-binary.conf" title="node/etc/examples/formats/villas-binary.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = {
			type = "villas.binary"

			source_index = 99
		}
	}
}
```

## Example Payload {#payload}

<figure align="center">
    <img alt="Wireshark capture of UDP traffic" src="/img/screenshots/node/wireshark_udp.png" width="90%" />
    <figcaption>Wireshark capture of UDP traffic.</figcaption>
</figure>
