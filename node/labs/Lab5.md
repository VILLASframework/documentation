# Lab 5: Send sine wave to simulator  {#node-guide-lab5}

@image html villas_pipe3.svg height=150px

We can combine the `villas signal` and  `villas pipe` tools to send a sine wave to a _node_.

In this lab, the _node_ is a RTDS GTNETv2 card running the SKT firmware.

We use a slightly modified configuration file in order to change the UDP packet format:

@includelineno lab5.conf

```
$ villas signal mixed -v 5 -f 50 -r 10000 | villas pipe lab5.conf rtds_gtnet1
```

As we can see in the diagram, the `villas pipe` tool also receives data which is sent by the simulator and prints it to the screen.