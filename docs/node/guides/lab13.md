---
sidebar_position: 13
---

# Lab 13: Measure Round-trip time between RTDS and VILLASnode

# Configuration

``` url="external/node/etc/labs/lab13.conf" title="node/etc/labs/lab13.conf"
affinity = 0x8,

nodes = {
	rtds_gtnet1 = {
		type = "socket",
		layer = "udp",
		format = "gtnet",

		in = {
			address = "*:12000"

			signals = {
				count = 8,
				type = "float"
			}
		},
		out = {
			address = "134.130.169.98:12000"
		}
	},
	rtds_gtnet2 = {
		type = "socket",
		layer = "udp",
		format = "gtnet",

		in = {
			address = "*:12001"

			signals = {
				count = 8,
				type = "float"
			}
		},
		out = {
			address = "134.130.169.99:12001"
		}
	}
}

paths = (
	{
		in  = "rtds_gtnet1"
		out = "rtds_gtnet2"

		reverse = true
	}
)
```

# RSCAD

**Source:** https://github.com/VILLASframework/node/tree/master/clients/rtds/gtnet_skt/gtnet_skt_udp_loopback_rtt

<figure align="center">
    <img alt="RSCAD draft for GTNET interface to VILLASnode" src="/img/screenshots/rscad/rscad_gtnet_skt_udp_loopback_rtt_draft.png" width="100%" />
    <figcaption>RSCAD draft for GTNET interface to VILLASnode.</figcaption>
</figure>

<figure align="center">
    <img alt="RSCAD runtime of GTNET interface to VILLASnode." src="/img/screenshots/rscad/rscad_gtnet_skt_udp_loopback_rtt_runtime.png" width="100%" />
    <figcaption>RSCAD runtime of GTNET interface to VILLASnode..</figcaption>
</figure>
