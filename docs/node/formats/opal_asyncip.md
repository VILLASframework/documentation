---
hide_table_of_contents: true
---

# OPAL-RT AsyncIP Example Format

VILLASnode supports the payload format used by OPAL-RT's AsyncIP example project shipped with their RT-Lab environment.

In the example project, the payload is defined by the following lines from the `AsyncIP.c` file as:

```c
// ****** FORMAT TO SPECIFIC PROTOCOL HERE ******************************
//
// Define the structure of the data that we send out. This is used in the
// SendToIPPort function
struct data_out
{
  short  dev_id;             // (2 bytes) Sender device ID
  int    msg_id;             // (4 bytes) Message ID
  short  msg_len;            // (2 bytes) Message length (data only)
  double data[MAXSENDSIZE];  // Up to MAXSENDSIZE doubles (8 bytes each)
};
//
// Define the structure of the data that we receive. This is used in the
// RecvFromIPPort function
struct data_in
{
  short  dev_id;             // (2 bytes) Sender device ID
  int    msg_id;             // (4 bytes) Message ID
  short  msg_len;            // (2 bytes) Message length (data only)
  double data[MAXRECVSIZE];  // Up to MAXRECVSIZE doubles (8 bytes each)
};
// **********************************************************************
```

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/opal_asyncip.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/villas_binary" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/opal-asyncip.conf" title="node/etc/examples/formats/opal-asyncip.conf"
nodes = {
	node = {
		type = "socket"
		layer = "udp"

		format = {
			type = "opal.asyncip"

			dev_id = 99
		}

		in = {
			# Port number specified in Asynchronous Process block of RTlab project
			address = ":12000"

			signals = {
				count = 64

				# The Asynchronous Process block only supports floating point values!
				type = "float"
			}
		}

		out = {
			# IP address and port of OPAL-RT Target
			address = "192.168.0.44:12000"
		}
	}
}
```
