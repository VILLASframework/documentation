---
sidebar_position: 20
---

# Lab 20: Socket TCP

This lab tutorial focuses on VILLASnode's [`socket`](../nodes/socket.md) node-type using a TCP connection. 

An example is created to test the connection between VILLASnode's [TCP client (`socket`)](../nodes/socket.md) with a [Signal Generator (`signal`)](../nodes/signal.md) and a TCP echo server [tcpbin.com](https://tcpbin.com). The echo server is response for receiving the data from TCP client and send the same data back for testing purpose.

## VILLASnode configuration file

``` url="external/node/etc/labs/lab20.conf" title="node/etc/labs/lab20.conf"
nodes = {
    tcp_node = {
        type = "socket"
        layer = "tcp-client"
        format = "villas.human"

        in = {
            address = "tcpbin.com:4242"
        },
        out = {
            address = "tcpbin.com:4242"
        }
    }
    siggen = {
        type = "signal"
        signal = [ "sine", "pulse", "square" ]
        values = 3, # value per sample
        rate = 1, # rate of sample
    }     
}

paths = (
    {
        in = "siggen"
        out = "tcp_node",
        hooks = ( { type = "print" } )
    },
    {
        in = "tcp_node", # Receive loopback answer.
        hooks = ( { type = "print" } )
    }
)
```

The configuration file includes the data generator which uses the `signal` node-type. 

The TCP client node is a simple socket node-type and serves as interface to the TCP echo server so that data can be sent. 
For TCP client the in and out address has to match a TCP server address, in this case [tcpbin.com](https://tcpbin.com/).
The last part of the configuration file specifies the paths. The first path ensures that generated data is send to TCP client node. 
The second path is responsible for receiving echo data from TCP server. 

To start open one terminal start the VILLASnode with the above configuration file:
```shell
villas node lab20.conf
```

In the VILLASnode output, you should see the send data twice because TCP server sends the received data back. 