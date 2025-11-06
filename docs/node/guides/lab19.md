---
sidebar_position: 19
---

# Lab 19: Python client

VILLASnode supports third-party clients to exchange signals with external tools or programming languages.
This lab focuses on using the Python programming language for exchanging signals with VILLASnode. 

A small example scenario is created to test the functionality of the Python client together with VILLASnode using the [Signal Generator](../nodes/signal.md) (`signal`) and [UDP Socket](../nodes/socket.md) (`socket`) node-types. 

## VILLASnode configuration file

``` url="external/node/etc/labs/lab19.conf" title="node/etc/labs/lab19.conf"
nodes = {
    udp_node = {
        type = "socket"
        layer = "udp"
        format = "protobuf"

        in = {
            address = "*:12000"

            signals = {
                count = 5   # expected incoming sample, send back from Python client, repeats samples if values in signal is smaller
                type = "float"
            }
            hooks = (
                {
                    type = "print"
                }
            )
        }

        out = {
            address = "127.0.0.1:12001"
        }
    }
    signal = {
        type = "signal"

        signal = "mixed"
        values = 5  # values per sample
        limit = 3   # emit limited number of samples
    }
}

paths = (
    {
        in = "signal"
        out = "udp_node"
    },
    {
	in = "udp_node"
    }

)
```

As already mentioned, the configuration files includes the data generator which is the signal node-type. 
Three samples are generated with five values. 

The udp node is a simple socket node-type and serves as interface to the Python client so that data can be sent. 
The output part, especially the port number, must match with the Python client configuration. 
It is important that the format type is protobuf, otherwise the udp node cannot decode data received by Python client. 

The last part of the configuration file specifies the paths. The first path ensures that generated data is send to udp node. The second path is responsible for receiving data from python client. 

## Python client configuration

The [`python client`](../clients/python.md) explains the corresponding configuration file. 

## Let's start

Open two terminals. In one terminal start the Python client: 

```shell
python3 client.py
```
In the other terminal, start the VILLASnode with above-described configuration file:

```shell
villas node lab19.conf
```

In Python client terminal, you should see the send data. 
In the VILLASnode output, you should see the send data twice because Python client sends the received data back. 