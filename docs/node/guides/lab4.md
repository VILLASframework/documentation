---
sidebar_position: 4
---

# Lab 4: Receive data from a node and show it on standard output

<figure align="center">
    <img alt="villas-pipe Example" src="/img/dia/villas_pipe2.svg" height="180px" />
    <figcaption>villas-pipe Example.</figcaption>
</figure>

Similarily, _samples_ which are send to the node are printed on the screen.
To demonstrate this we start `villas pipe` a second time with swapped `local` and `remote` addresses.

In the first terminal:
```bash
villas pipe lab3.conf udp_node1
```

<asciinema-player rows="25" cols="500" poster="npt:0:1"  src="/recordings/terminal/lab4_t1.json" />

In a second terminal, we use `-x` to exchange input/output addresses:
```bash
villas pipe -x lab3.conf udp_node1
```

<asciinema-player rows="25" cols="500" poster="npt:0:1"  src="/recordings/terminal/lab4_t2.json" />

# Stopping `villas pipe` {#node-guide-lab4-stopping}

By default, `pipe` terminates as soon as the input stream reaches the end.
In the examples above, the input stream is connected to the terminal where it wait for data entered by the keyboard.
In this case, the end of the stream is emitted by pressing Ctrl-D.
If the input stream is connected to a file, reaching the end of the file will cause termination of `villas pipe`.

Furthermore, the tool supports three more modes to terminate itself:

 - If called with the `-l NUM` switch, `villas pipe` terminates after `NUM` received samples.
 - If called with the `-L NUM` switch, `villas pipe` terminates after `NUM` sent samples.
 - If called witht the `-t NUM` switch, `villas pipe` terminates after `NUM` seconds of execution.
