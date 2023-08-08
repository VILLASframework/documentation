---
sidebar_position: 19
---

# Lab 19: Python client

Villas supports third party clients. This lab focuses on the python client. 
A small scenario is created to test the functionality of the python client together with villas using data generation and udp node. 

## Villas configuration file

``` url="external/node/etc/labs/lab19.conf" title="node/etc/labs/lab19.conf"
nodes = {
    udp_node = {
        type = "socket"
        layer = "udp"
        format = "protobuf"

        in = {
            address = "*:12000"

            signals = {
                count = 5   # expected incoming sample, send back from python client, repeats samples if values in signal is smaller
                type = "float"
            }
            hooks = (
            {
                type = "print"
            }
        )
        },
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
Three samples are genereated with five values. 
The udp node is a simple socket node-type and serves as interface to the python client so that data can be sent. The out part, especially the port number, must match with the python client configuration. 
It is important that the format type is protobuf, otherwise the udp node cannot decode data recevied by python client. 
The last part of the configuration file specifies the paths. The first path ensures that generated data is send to udp node. The second path is responsible for receiving data from python client. 

## Python client configuration
The [`python client`](../clients/python.md) explains the corresponding configuration file. 

## Let's start
Open two terminals. In one terminal start the python client: 
```shell
python3 client.py
```
In the other terminal, start the villas node with above-described configuration file:
```shell
villas node lab19.conf
```
In python client terminal, you should see the send data. 
In villas output, you should see the send data twice because python client sends the received data back. 