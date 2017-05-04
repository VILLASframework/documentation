# Getting started guide {#node-guide}

[TOC]

We put some effort in getting you started as smooth as possible.
This tutorial introduces the basic concepts and terminologies of VILLASnode and shows some example use cases.

# Preperation {#node-guide-preperation}

Several options to install VILLASnode are documented on the @ref node-installation page.

For this guide, we recommend to use the [VILLASnode Docker image](@ref node-installation-docker) on your workstation.

# VILLASnode {#node2}

VILLASnode is a central component in the VILLASframework.
Its main purpose is the routing of simulation data.

## Terminology {#node-terminology}

Before we start to use the VILLASnode tools, we will introduce some terminology:

- A _super node_ is an instance of the VILLASnode daemon which runs on a physical machine.
- A _node_ is an interface to a local or remote simulator, file, database etc. A _super node_ consists of one or more _nodes_. A _node_ acts as a sink **and** as a source of _samples_.
- A _sample_ is an array of floating point or integer values with an associated timestamp and sequence number.
- A _path_ connects one or more _nodes_ within a _super node_ and forwards _samples_ from one or more _ source nodes_ to one or more _destination nodes_.
- A _hook_ manipulates or filters _samples_ which are processed by a _path_.

## Tools {#node-tools}

VILLASnode is a collection of command line tools which follow the [Unix pholosophy](https://en.wikipedia.org/wiki/Unix_philosophy):

1. Make each program do one thing well. To do a new job, build afresh rather than complicate old programs by adding new "features".
1. Expect the output of every program to become the input to another, as yet unknown, program. Don't clutter output with extraneous information. Avoid stringently columnar or binary input formats. Don't insist on interactive input.
1. Design and build software, even operating systems, to be tried early, ideally within weeks. Don't hesitate to throw away the clumsy parts and rebuild them.
1. Use tools in preference to unskilled help to lighten a programming task, even if you have to detour to build the tools and expect to throw some of them out after you've finished using them.

In this guide we will show the following tools:

| Tool			| Purpose |
| :----			| :---- |
| `villas signal`		| A signal generator for testing and training purposes. |
| `villas pipe`		| Send / receive _samples_ to / from _nodes_ via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |
| `villas hook`		| Filter or manipulate _samples_ provided via [standard IO streams](https://en.wikipedia.org/wiki/Standard_streams). |
| `villas node`		| The VILLASnode deamon. |
| `villas test-cmp` 	| Compare _sample_ files. |

A complete reference of all available options for those tools can be found at the @ref node-usage page.

## Demos {#node-guide-demos}

### Signal generation

The first and simplest utility of the VILLASnode toolbox is a signal generator.
Rarely used in a real simulation, this tool can be handy for testing and understanding other commands of VILLASnode.

The following command emits a stream of samples to the [standard output](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29) of your terminal:

```
$ villas signal sine -l 10 -r 10 -f 3 -v 1
```

The samples have the following characteristics:

| Option	| Description |
| :---	| :--- |
| `-l 10` | Limits the output to 10 samples |
| `-r 10` | Samples the signal with a rate of 10 Hz |
| `-f 3` 	| Sets the frequency of the generated signal to 3 Hz |
| `-v 1` 	| Sets the number of values which are generated |

@htmlonly
<asciinema-player poster="npt:0:1" src="recordings/villas_signal.json">
@endhtmlonly

Every sample is printed in a single line consisting of several columns:

```
# sec.nsec(seq)          data[]
1493840575.228483413(0)  0.000000
```

The first column is a combination of timestamp and sequence number in the form of `seconds.nanoseconds+offset(sequenceno)`.
The remaining columns contain the values of the sample.

If you add the `-n` (non real-time mode) switch the data will be printed immeadiately to the screen:

```
$ villas signal sine -l 10 -r 10 -f 3 -v 1 -n
```

@htmlonly
<asciinema-player poster="npt:0:1"  src="recordings/villas_signal_nrt.json">
@endhtmlonly

You can use [shell redirection](https://www.gnu.org/software/bash/manual/html_node/Redirections.html) to write those samples to a file:

```
$ villas signal sine -l 10 -r 10 -f 3 -v 1 -n > file.dat
$ cat file.dat
```

@htmlonly
<asciinema-player poster="npt:0:1"  src="recordings/villas_signal_file.json">
@endhtmlonly

### A simple configuration file

Before we proceed to other tools,  we need to get familiar with VILLASnode's configuration file format.
The configuration file is used to describe the connectivity of a _super node_. Hence, it contains a list of _nodes_ and _paths_ and general settings.
A reference of all available configuration options is available on the @ref node-config page.

VILLASnode supports two formats for its configuration file:

- [JSON](http://json.org)
- [libconfig](http://www.hyperrealm.com/libconfig/libconfig_manual.html#Configuration-Files)

Due to its suprior readability, we will use the [libconfig](http://www.hyperrealm.com/libconfig/libconfig_manual.html#Configuration-Files) format in this tutorial.

We start with `example1.conf`: @includelineno node/etc/example1.conf

### Sending / receiving data to / from _nodes_ via standard streams

The `villas pipe` tool can be used to send and receive sample to / from a node.

```
$ echo "1493840575.228483413(0)  1.2345" | villas pipe example1.conf example_node1
```


@htmlonly
<asciinema-split>
	<asciinema-player poster="npt:0:1"  src="recordings/villas_signal_nrt.json"></asciinema-player>
	<asciinema-player poster="npt:0:1"  src="recordings/villas_signal.json"></asciinema-player>
</asciinema-split>
@endhtmlonly

Send random data to a simulator:

```
$ villas pipe example1.conf example_node
```

Receive data from node `node1` and save to file `file.dat`:

```
$ villas pipe etc/example.conf node1 > file.dat
```

Send samples from file `file.dat` to `node1`:

```
$ villas pipe etc/example.conf node1 < file.dat
```

### Process data with hook functions: `villas hook`

Skip first 10 seconds of a sample stream:

```
$ villas signal sine | villas hook skip_first seconds=10
```

### The daemon: `villas node`

```
$ villas node etc/example.conf
```

# VILLASweb {#node-guide-web}

# An example setup {#node-guide-example}