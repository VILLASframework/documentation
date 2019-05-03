# Advanced Messaging & Queuing Protocol (AMQP) {#node-type-amqp}

The @ref node-type-amqp node-type exchanges messages over the AMQP protocol with a broker such as [RabbitMQ](https://www.rabbitmq.com).

A typical publish/subscribe pattern is used:
The node automatically declares a _direct_ exchange and dedicated queues for each subscriber.

# Prerequisites {#node-prereq-amqp}

This node-type requires [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) (>= 0.8.0).

# Implementation {#node-implementation-amqp}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/amqp.c

# Configuration {#node-config-node-amqp}

## format (string) {#node-config-node-amqp-format}

The payload format which is used to encode and decode exchanged messages.

## uri (string) {#node-config-node-amqp-uri}

See also: https://www.rabbitmq.com/uri-spec.html

## exchange (string) {#node-config-node-amqp-exchange}

The name of the AMQP exchange the node will publish the messages to.

## routing_key (string) {#node-config-node-amqp-routing_key}

The routing key of published messages as well as the routing key which is used to bind the subcriber queue.

## ssl (object) {#node-config-node-amqp-ssl}

**Note:** These settings are only used if the @ref node-config-node-amqp-uri setting is using the `amqps://` schema.

## Example

@include node/etc/examples/nodes/amqp.conf
