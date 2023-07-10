---
sidebar_position: 3
---

# Lab 3: Sending data to node from standard input

import AsciinemaPlayer from '@site/src/components/AsciinemaPlayer';
import 'asciinema-player/dist/bundle/asciinema-player.css';

<figure align="center">
    <img alt="villas-pipe Example" src="/img/drawio/villas_pipe1.svg" height="180px" />
    <figcaption>villas-pipe Example.</figcaption>
</figure>

The `villas pipe` tool can be used to send and receive sample to / from a node.

The following command sends a single _sample_ to node `udp_node1`.

```shell
# start tcpdump to capture traffic in background
tcpdump -i lo udp port 12001

# send 10 values to udp_node1
villas signal -v 3 -r 10 -l 10 mixed | villas pipe lab3.conf udp_node1

# stop tcpdump
kill %1
```

We can verify this by using Wireshark or `tcpdump`:

<AsciinemaPlayer src="/recordings/terminal/villas_pipe_tcpdump.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />

<figure align="center">
    <img alt="Wireshark capture of UDP traffic" src="/img/screenshots/node/wireshark_udp.png" width="90%" />
    <figcaption>Wireshark capture of UDP traffic.</figcaption>
</figure>
