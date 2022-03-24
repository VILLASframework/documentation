---
sidebar_position: 7
---

# Lab 7: Read samples from file and send them to node

import AsciinemaPlayer from '@site/src/components/AsciinemaPlayer';
import 'asciinema-player/dist/bundle/asciinema-player.css';

## Easy way (non real-time)

<figure align="center">
    <img alt="Send and receive samples from files to simulator" src="/img/drawio/villas_pipe_file2.svg" height="180px" />
    <figcaption>Send and receive samples from files to simulator.</figcaption>
</figure>

```bash
villas pipe lab3.conf udp_node1 < file_send.dat > file_recv.dat
```

**Note:** In this lab all samples of `file.dat` will be sent immediately to `udp_node1`.
Usually, this is not the desired behavior.
We will show later how to stream the samples _in real-time_ to a destination node.

## Better way (real-time)

``` url="external/node/etc/labs/lab7.conf" title="node/etc/labs/lab7.conf"
nodes = {
	file_node1 = {
		type = "file",

		uri = "file_send.dat"
		
		in = {
			
		}
	}
}
```

In order to stream the samples in real-time from a file, we will use the [`file`](../nodes/file.md) node-type with the following configuration file (`lab7.conf`):

<figure align="center">
    <img alt="Stream samples in real-time from file" src="/img/drawio/villas_pipe_file3.svg" width="50%" />
    <figcaption>Stream samples in real-time from file.</figcaption>
</figure>

```bash
villas pipe lab7.conf file_node1 | villas pipe lab3.conf udp_node1 > file_recv.dat
```

<AsciinemaPlayer src="/recordings/terminal/villas_pipe_file.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />
