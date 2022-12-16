---
sidebar_position: 1
---

# Getting Started

We put some effort in getting you started as smooth as possible.
This tutorial introduces the basic concepts and terminologies of VILLASnode and shows some examples.

Please look below for a [video recording](#video) of a webinar covering the topics of this guide.

## Preparation

:::caution
Please make sure that your system fulfills the [requirements](../requirements.md) before proceeding.
:::

The [installation](installation.md) page lists several ways to install VILLASnode on your machine.

For this guide, we recommend to use the [VILLASnode Docker image](../installation.md#docker) on your workstation.

To open an interactive terminal in the VILLASnode Docker container run:

```bash
docker run --privileged --tty --interactive --entrypoint bash --volume C:\path\to\configs:/configs -p 80:80 registry.git.rwth-aachen.de/acs/public/villas/node
```

For some lab exercises two interactive shells are required. To open a second shell, run the following command:

```bash
docker exec --tty --interactive $(docker ps -qn1) bash
```

## Terminology

Before we start to use the VILLASnode tools, we will introduce some terminology:

- A _super node_ is an instance of the VILLASnode daemon which runs on a physical machine.
- A _node_ is an interface to a local or remote simulator, file, database etc. A _super node_ consists of one or more _nodes_. A _node_ acts as a sink **and** as a source of _samples_.
- A _sample_ is an array of floating point or integer values with an associated timestamp and sequence number.
- A _path_ connects one or more _nodes_ within a _super node_ and forwards _samples_ from one or more _source nodes_ to one or more _destination nodes_.
- A _hook_ manipulates or filters _samples_ which are processed by a _path_.

<figure align="center">
    <img alt="A two site scenario with VILLASfpga." src="/img/VILLASnode_large.svg" width="75%" />
	<figcaption>A two site scenario with VILLASfpga.</figcaption>
</figure>

## Tools

VILLASnode is a collection of command line tools which follow the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy):

1. Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new "features".
2. Expect the output of every program to become the input to another, as yet unknown, program. Don't clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don't insist on interactive input.
3. Design and build software, even operating systems, to be tried early, ideally within weeks. Don't hesitate to throw away the clumsy parts and rebuild them.
4. Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you've finished using them.

In this guide we will show the following tools:

| Tool					                        | Purpose |
| :----					                        | :---- |
| [`villas node`](../usage/villas-node.md)		| The main VILLASnode daemon. |
| [`villas signal`](../usage/villas-signal.md)	| A signal generator for testing and training purposes. |
| [`villas pipe`](../usage/villas-pipe.md)		| Send / receive _samples_ to / from _nodes_ via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |
| [`villas hook`](../usage/villas-hook.md)		| Filter or manipulate _samples_ provided via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |

A complete list of available tools and commandline options can be found on the [usage](../usage/index.md) page.

## Lab assignments {#labs}

To get you started quickly, we prepared a series of small demos which you can try yourself.

- [**Lab1**](lab1.md): Signal generation
- [**Lab2**](lab2.md): A simple configuration file
- [**Lab3**](lab3.md): Sending data to node from standard input
- [**Lab4**](lab4.md): Receive data from a node and show it on standard output
- [**Lab5**](lab5.md): Send sine wave to simulator
- [**Lab6**](lab6.md): Write received sample data to a file
- [**Lab7**](lab7.md): Read samples from file and send them to node
- [**Lab8**](lab8.md): Use hook function to modify/filter the data
- [**Lab9**](lab9.md): Network emulation and statistics
- [**Lab10**](lab10.md): The daemon
- [**Lab11**](lab11.md): Multi / De-multiplexing
- [**Lab12**](lab12.md): WebSockets
- [**Lab13**](lab13.md): Measure Round-trip time between RTDS and VILLASnode
- [**Lab14**](lab14.md): File comparison
- [**Lab15**](lab15.md): Working with EtherCAT
- [**Lab16**](lab16.md): Visualize simulation data with InfluxDB and Grafana
- [**Lab17**](lab17.md): RTDS-RTDS Co-simulation

:::note
All configurations files are available here: <https://github.com/VILLASframework/node/tree/master/etc/labs>
:::

## Video

This webinar was recorded during the preparation of the RT-SuperLab demonstration.

- **Date:** 8th May 2017
- **Versions:** VILLASnode v0.3
- **Speaker:** [Steffen Vogel](mailto:post@steffenvogel.de)

:::caution
This video presents an outdated version of VILLASnode!
:::

<video controls width="100%" align="center">
	<source src="https://videos.fein-aachen.org/VILLASnode_Webinar_2017_05_08.mp4" type="video/mp4" />
</video>
