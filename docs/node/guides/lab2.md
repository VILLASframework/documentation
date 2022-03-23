---
sidebar_position: 2
---

# Lab 2: A simple configuration file

Before we proceed to other tools,  we need to get familiar with VILLASnode's configuration file format.
The configuration file is used to describe the connectivity of a _super node_. Hence, it contains a list of _nodes_ and _paths_ and general settings.
A reference of all available configuration options is available on the [configuration](../config/index.md) page.

VILLASnode supports two formats for its configuration file:

- [JSON](http://json.org)
- [libconfig](http://www.hyperrealm.com/libconfig/libconfig_manual.html#Configuration-Files)

Due to its easy readability, we will use the [libconfig](http://www.hyperrealm.com/libconfig/libconfig_manual.html#Configuration-Files) format in this tutorial.

For the next couple labs, we will use the following simple configuration file named `lab3.conf`.
It only contains a single node named `udp_node1` which sends / receives samples via IP / UDP on port 12000.

``` url="external/node/etc/labs/lab3.conf" title="node/etc/labs/lab3.conf"
nodes = {
	udp_node1 = {
		type = "socket",
		layer = "udp",

		in = {
			address = "*:12000"

			signals = {
				count = 3
				type = "float"
			}
		},
		out = {
			address = "127.0.0.1:12001"
		}
	}
}
```
