---
sidebar_position: 9
---

# Lab 9: Network emulation and statistics

import AsciinemaPlayer from '@site/src/components/AsciinemaPlayer';
import 'asciinema-player/dist/bundle/asciinema-player.css';

<figure align="center">
    <img alt="villas-hook Example" src="/img/dia/villas_hook_stats.svg" height="180px" />
    <figcaption>villas-hook Example.</figcaption>
</figure>

The `stats` hook can be used to collect statistics about the co-simulation interface like:

- One way delay (OWD)
- Packet loss
- Packet reordering
- Sending rate

```shell
villas signal -r 1000 -l 10000 sine | villas hook -o verbose=true -o warmup=3000 stats
```

## With network emulation

<figure align="center">
    <img alt="villas-hook Example" src="/img/dia/villas_hook_stats_netem.svg" height="180px" />
    <figcaption>villas-hook Example.</figcaption>
</figure>

``` url="external/node/etc/labs/lab9_netem.conf" title="node/etc/labs/lab9_netem.conf"
nodes = {
	udp_node1 = {
		type = "socket",
		layer = "udp",

		in = {
			address = "*:12000"

			signals = {
				count = 8,
				type = "float"
			}
		},
		out = {
			address = "127.0.0.1:12001",

			netem = {
				enabled   = true,
				loss      = 0,      # in %
				corrupt   = 0,      # in %
				duplicate = 0,      # in %
				delay     = 100000, # in uS
				jitter    =   5000, # in uS
				distribution = "normal"
			}
		}
	}
}
```

In  the first terminal:

```shell
villas signal -r 1000 sine | villas pipe etc/lab9_netem.conf udp_node1
```

In a second terminal:

```shell
villas pipe etc/lab9_netem.conf udp_node1 -x > delayed_data.dat
```

After a few seconds, press Ctrl-C to stop the processing. Now we can analyze the delay distribution of the received data:

```shell
villas hook -o verbose=true -o warmup=1000 stats < delayed_data.dat > /dev/null
```

<AsciinemaPlayer src="/recordings/terminal/villas_hook_stats.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />

For more details see here: [Network Emulation](../netem.md).
