# Getting started guide {#node-guide}

[TOC]

We put some effort in getting you started as smooth as possible.
This tutorial introduces the basic concepts and terminologies of VILLASnode and shows some example use cases.

# Preperation {#node-guide-preperation}

Several options to install VILLASnode are documented on the @ref node-installation page.

For this guide, we recommend to use the [VILLASnode Docker image](@ref node-installation-docker) on your workstation.

To open an interactive terminal in the VILLASnode Docker container run:

```bash
$ docker run --tty --interactive --entrypoint bash villas/node
```

For some @ref node-guide-labs two interactive shells are required. To open a second shell, run the following command:

```bash
$ docker exec -it $(docker ps -qn1) bash
````

# Terminology {#node-terminology}

Before we start to use the VILLASnode tools, we will introduce some terminology:

- A _super node_ is an instance of the VILLASnode daemon which runs on a physical machine.
- A _node_ is an interface to a local or remote simulator, file, database etc. A _super node_ consists of one or more _nodes_. A _node_ acts as a sink **and** as a source of _samples_.
- A _sample_ is an array of floating point or integer values with an associated timestamp and sequence number.
- A _path_ connects one or more _nodes_ within a _super node_ and forwards _samples_ from one or more _source nodes_ to one or more _destination nodes_.
- A _hook_ manipulates or filters _samples_ which are processed by a _path_.

# Tools {#node-tools}

VILLASnode is a collection of command line tools which follow the [Unix pholosophy](https://en.wikipedia.org/wiki/Unix_philosophy):

1. Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new "features".
2. Expect the output of every program to become the input to another, as yet unknown, program. Don't clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don't insist on interactive input.
3. Design and build software, even operating systems, to be tried early, ideally within weeks. Don't hesitate to throw away the clumsy parts and rebuild them.
4. Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you've finished using them.

In this guide we will show the following tools:

| Tool			| Purpose |
| :----			| :---- |
| `villas signal`		| A signal generator for testing and training purposes. |
| `villas pipe`		| Send / receive _samples_ to / from _nodes_ via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |
| `villas hook`		| Filter or manipulate _samples_ provided via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |
| `villas node`		| The VILLASnode deamon. |
| `villas test-cmp` 	| Compare _sample_ files. |

A complete reference of all available options for those tools can be found at the @ref node-usage page.

# Lab assignments {#node-guide-labs}

To get you started quickly, we prepared a series of small demos which you can yourself.

- @subpage node-guide-lab1
- @subpage node-guide-lab2
- @subpage node-guide-lab3
- @subpage node-guide-lab4
- @subpage node-guide-lab5
- @subpage node-guide-lab6
- @subpage node-guide-lab7
- @subpage node-guide-lab8
- @subpage node-guide-lab9
- @subpage node-guide-lab10

# Video {#node-guide-video}

@todo A recording of the Webinar will be provided soon.