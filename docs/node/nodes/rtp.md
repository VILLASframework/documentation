---
sidebar_label: RTP
hide_table_of_contents: true
---

# Real-Time Protocol (RTP & RTCP)

## Prerequisites

This node-type requires [libre](http://www.creytiv.com/re.html) (>= 0.6.0).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/rtp.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/rtp" />

## Example

``` url="external/node/etc/examples/nodes/rtp.conf" title="node/etc/examples/nodes/rtp.conf"
nodes = {
	rtp_node = {
		type = "rtp"

		format = {
			type = "raw"
			bits = 32
			endianess = "big"
		}

		rtcp = false

		aimd = {
			a = 10,
			b = 0.5

			Kp = 1.0
			Ki = 0.0
			Kd = 0

			rate_min = 100
			rate_init = 2000
			rate_source = 10000

			log = "aimd-rates-%Y_%m_%d_%s.log"

			hook_type = "limit_rate"
		}

		in = {
			address = "0.0.0.0:12000",
			signals = {
				count = 3
				type = "float"
			}
		}

		out = {
			address = "127.0.0.1:12000"

			netem = {			# Network emulation settings
				enabled = false,
				
				delay = 100000,		# Additional latency in microseconds
				loss = 10		# Packet loss in percent
			}
		}
	}
}
```

## Further reading

- https://en.wikipedia.org/wiki/Real-time_Transport_Protocol
- https://www.ietf.org/proceedings/67/slides/avt-1.pdf
- https://csperkins.org/standards/ietf-64/2005-11-10-IETF64-DCCP-rtp-dccp.pdf
- https://tools.ietf.org/html/rfc5762
- https://tools.ietf.org/html/rfc4340
