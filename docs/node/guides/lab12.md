---
sidebar_position: 12
---

# Lab 12: WebSockets

<figure align="center">
    <img alt="Websocket node-type Example" src="/img/dia/villas_node_websocket.svg" height="180px" />
    <figcaption>Websocket node-type Example.</figcaption>
</figure>

In this lab we will show you the VILLASnode WebSockets mockup.
The mockup is a simple webpage which receives / sends simulation from / to VILLASnode by using low latency WebSockets.

This technique is usefull for live monitoring and user interaction with simulations.

## The configuration file

@includelineno node/etc/labs/lab12.conf

## Start node and signal generator

```bash
villas signal -v 4 -r 120 mixed | villas pipe -x lab3.conf udp_node1 &
villas node lab12.conf
```

## Web Mockup

![](/img/screenshots/node/web_mockup.png)
