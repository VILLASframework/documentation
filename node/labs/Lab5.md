# Lab 5: Send sine wave to simulator  {#node-guide-lab5}

@image html villas_pipe3.svg height=170px

We can combine the `villas signal` and  `villas pipe` tools to send a sine wave to a _node_.

In this lab, the _node_ is a RTDS GTNETv2 card running the SKT firmware.

We use a slightly modified configuration file in order to change the UDP packet format:

@includelineno lab5.conf

```
$ villas signal mixed -v 4 -r 1000 | villas pipe lab5.conf rtds_gtnet1
$ villas signal sine -f 50 -r 10000 | villas pipe lab5.conf rtds_gtnet1
```

As we can see in the diagram, the `villas pipe` tool also receives data which is sent by the simulator and prints it to the screen.

# RSCAD

**Source:** <https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/develop/clients/rtds/gtnet_skt/gtnet_skt_udp_2point>

@image html rscad_gtnet_skt_2point_udp_draft.png RSCAD draft for GTNET interface to VILLASnode. width=100%

@image html rscad_gtnet_skt_2point_udp_runtime.png RSCAD runtime of GTNET interface to VILLASnode. width=100%
