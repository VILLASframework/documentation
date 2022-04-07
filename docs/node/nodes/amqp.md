---
sidebar_label: AMQP
hide_table_of_contents: true
---

# Advanced Messaging & Queuing Protocol (AMQP)

The `amqp` node-type exchanges messages over the AMQP protocol with a broker such as [RabbitMQ](https://www.rabbitmq.com).

A typical publish/subscribe pattern is used:
The node automatically declares a _direct_ exchange and dedicated queues for each subscriber.

## Prerequisites

This node-type requires [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) (>= 0.8.0).

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/amqp.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/amqp" />

## Example

``` url="external/node/etc/examples/nodes/amqp.conf" title="node/etc/examples/nodes/amqp.conf"
nodes = {
	amqp_node = {
		type = "amqp",
		format = "json",

		# Use 'amqps://' to enable SSL/TLS
		uri = "amqp://username:password@example.com:1234/vhost",

		# Alternatively connection settings can be specified individually
		username = "guest",
		password = "guest",
		host = "localhost",
		vhost = "/",
		port = 5672,

		exchange = "mytestexchange",
		routing_key = "abc",

		ssl = {
			verify_hostname = true,
			verify_peer = true,

			ca_cert = "/path/to/ca.crt",
			client_cert = "/path/to/client.crt",
			client_key = "/path/to/client.key"
		}
	}
}
```
