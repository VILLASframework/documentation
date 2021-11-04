---
sidebar_position: 6
---

# Lab 6: Write received sample data to a file

<figure align="center">
    <img alt="villas-pipe Example" src="/img/dia/villas_pipe_file.svg" height="180px" />
    <figcaption>villas-pipe Example.</figcaption>
</figure>

Receive data from node `udp_node1` and save to file `file.dat`:

```bash
villas pipe lab3.conf udp_node1 > file.dat
```

<asciinema-player rows="25" cols="500" poster="npt:0:13"  src="/recordings/terminal/lab6.json" />
