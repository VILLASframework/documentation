---
sidebar_position: 6
---

# Lab 6: Write received sample data to a file

import AsciinemaPlayer from '@site/src/components/AsciinemaPlayer';
import 'asciinema-player/dist/bundle/asciinema-player.css';

<figure align="center">
    <img alt="villas-pipe Example" src="/img/drawio/villas_pipe_file.svg" height="180px" />
    <figcaption>villas-pipe Example.</figcaption>
</figure>

Receive data from node `udp_node1` and save to file `file.dat`:

```bash
villas pipe lab3.conf udp_node1 > file.dat
```

<AsciinemaPlayer src="/recordings/terminal/lab6.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />
