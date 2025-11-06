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

This technique is useful for live monitoring and user interaction with simulations.

## The configuration file

``` url="external/node/etc/labs/lab12.conf" title="node/etc/labs/lab12.conf"
nodes = {
    udp_node1 = {
        type = "socket"
        layer = "udp"

        in = {
            address = "*:12000"

            signals = {
                count = 8
                type = "float"
            }
        }

        out = {
            address = "127.0.0.1:12001"
        }
    }

    web_node1 = {
        type = "websocket"

        vectorize = 2
        series = (
            { label = "Random walk", unit = "V"   },
            { label = "Sine",        unit = "A"   },
            { label = "Rect",        unit = "Var" },
            { label = "Ramp",        unit = "Â°C"  }
        )
    }
}

paths = (
    {
        in  = [ "udp_node1" ]
        out = [ "web_node1" ]

        hooks = (
            # We do not want to overload the WebBrowsers
            { type = "decimate", ratio = 2 }
        )
    },
    {
        in  = [ "web_node1" ]
        out = [ "udp_node1" ]

        # Web -> UDP does not require decimation
    }
)
```

## Start node and signal generator

```shell
villas signal -v 4 -r 120 mixed | villas pipe -x lab3.conf udp_node1 &
villas node lab12.conf
```

## Web Mockup

![](/img/screenshots/node/web_mockup.png)
