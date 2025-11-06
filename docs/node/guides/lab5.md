---
sidebar_position: 5
---

# Lab 5: Send sine wave to simulator

<figure align="center">
    <img alt="villas-pipe Example" src="/img/drawio/villas_pipe3.svg" height="180px" />
    <figcaption>villas-pipe Example.</figcaption>
</figure>

We can combine the `villas signal` and  `villas pipe` tools to send a sine wave to a _node_.

In this lab, the _node_ is a RTDS GTNETv2 card running the SKT firmware.

We use a slightly modified configuration file in order to change the UDP packet format:

``` url="external/node/etc/labs/lab5.conf" title="node/etc/labs/lab5.conf"
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
            address = "134.130.169.89:12000"
        }
    }
}
```

```shell
villas signal -v 4 -r 1000 mixed | villas pipe lab5.conf rtds_gtnet1
villas signal -f 50 -r 10000 sine | villas pipe lab5.conf rtds_gtnet1
```

As we can see in the diagram, the `villas pipe` tool also receives data which is sent by the simulator and prints it to the screen.

# RSCAD

**Source:** https://github.com/VILLASframework/node/tree/master/clients/rtds/gtnet_skt/gtnet_skt_udp_2point

<figure align="center">
    <img alt="RSCAD draft for GTNET interface to VILLASnode" src="/img/screenshots/rscad/rscad_gtnet_skt_2point_udp_draft.png" width="100%" />
    <figcaption>RSCAD draft for GTNET interface to VILLASnode.</figcaption>
</figure>

<figure align="center">
    <img alt="RSCAD runtime of GTNET interface to VILLASnode" src="/img/screenshots/rscad/rscad_gtnet_skt_2point_udp_runtime.png" width="100%" />
    <figcaption>RSCAD runtime of GTNET interface to VILLASnode.</figcaption>
</figure>
