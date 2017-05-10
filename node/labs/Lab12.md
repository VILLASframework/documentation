# Lab 12: WebSockets {#node-guide-lab12}

@image html villas_node_websocket.svg height=150px

In this lab we will show you the VILLASnode WebSockets mockup.
The mockup is a simple webpage which receives / sends simulation from / to VILLASnode by using low latency WebSockets.

This technique is usefull for live monitoring and user interaction with simulations.

## The configuration file

@includelineno lab12.conf

## Start node and signal generator

```bash
$ villas signal mixed -v 4 -r 120 | villas pipe lab3.conf udp_node1 -x &
$ villas node lab12.conf
```

## Web Mockup

@image html web_mockup.png