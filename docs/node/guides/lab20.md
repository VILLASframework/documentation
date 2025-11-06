---
sidebar_position: 20
---

# Lab 20: Socket TCP

This lab tutorial focuses on VILLASnode's [`socket`](../nodes/socket.md) node-type using a TCP connection. 

An example is created to test the connection between VILLASnode's [TCP client (`socket`)](../nodes/socket.md) with a [Signal Generator (`signal`)](../nodes/signal.md) and VILLASnode's [TCP server (`socket`)](../nodes/socket.md). The server act as a echo server and is response for receiving the data from TCP client and send the same data back for testing purpose.

## VILLASnode configuration file

### TCP server

``` url="external/node/etc/labs/lab20-server.conf" title="node/etc/labs/lab20-server.conf"
nodes = {
    tcp_node = {
        type = "socket"

        layer = "tcp-server"

        format = "villas.human"

        in = {
            address = "127.0.0.1:12000"
        }

        out = {
            address = "127.0.0.1:12000"
        }
    }
}
paths = (
    {
        in = "tcp_node"
        out = "tcp_node"
        hooks = ( { type = "print" } )
    }
)
```
### TCP client with signal generator

``` url="external/node/etc/labs/lab20.conf" title="node/etc/labs/lab20.conf"
nodes = {
    tcp_node = {
        type = "socket"

        layer = "tcp-client"

        format = "villas.human"

        in = {
            address = "127.0.0.1:12000"
        }
        out = {
            address = "127.0.0.1:12000"
        }
    }
    siggen = {
        type = "signal"
        signal = [ "sine", "pulse", "square" ]
        values = 3 # Values per sample
        rate = 10 # Sample rate
    }
}
paths = (
    {
        in = "siggen"
        out = "tcp_node"
        hooks = ( { type = "print" } )
    },
    {
        in = "tcp_node" # Receive loopback answer.
        hooks = ( { type = "print" } )
    }
)
```

The first configuration file is for TCP server. The server will bind itself to the in address. 
The path specifies in the first configuration is response for loop the data back to the client.

The second configuration file includes the data generator which uses the `signal` node-type. 
The TCP client node is a simple socket node-type and serves as interface to the TCP server so that data can be sent. 
For TCP client the in and out address has to match a TCP server address.
The last part of the configuration file specifies the paths. The first path ensures that generated data is send to TCP client node. 
The second path is responsible for receiving echo data from TCP server. 

To start open two terminal and start the VILLASnode with the above configuration file.
In the first terminal:
```shell
villas node lab20-server.conf
```
In second terminal:
```shell
villas node lab20.conf
```
In the first terminal, you should see the data that TCP server received and send back to the client.

In the second terminal, you should see the send data twice because TCP server sends the received data back. 