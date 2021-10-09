---
sidebar_position: 10
---

# Lab 10: The daemon {#node-guide-lab10}

During the previous labs, we use the `villas pipe`, `villas hook` and `villas signal` tools connect simulators and process the exchanged simulation data. This approach is handy for small tests, development and training.
However, more complex scenaries are unmanagable with this approach.

In this lab we introduce the VILLASnode daemon `villas node` which provides an easier way to setup complex scenarios.
In addition, `villas node` benefits from lower latencies because we omit the standard input / output streams and the conversion of the samples in a human readable / line-based representation.

**Note:** We recommend the usage of the daemon for all real-time critical HIL simulations

The invocation of the daemon is pretty simple.
Just pass the path to the configuration file as a paramteter:

```bash
villas node lab10_path_uni.conf
```

All VILLASnode tools can fetch their configuration file from remote locations (all [protocols from libcurl](https://curl.haxx.se/libcurl/c/CURLOPT_PROTOCOLS.html) are supported):

```bash
# From a web server
villas node https://villas.fein-aachen.org/doc/etc/lab3.conf

# From a Windows share (use single quotes!)
villas node 'smb://domain\user:passwd@example.com/share/file.conf'

# From a FTP server
villas node ftp://user:passwd@example.com/lab3.conf'

# Via SSH / SFTP
villas node sftp://user:passwd@example.com/etc/villas/node/lab3.conf
```

## Example configurations

All of the following examples use the same set of nodes, which we define in the file `lab10_nodes.conf`:

@includelineno node/etc/labs/lab10_nodes.conf Nodes for the following examples.

### A unidirectional path

**Todo:** Please note, that currently each node must only used once as an input node. Using the same node as an input to multiple paths is not possible. Please consider using @ref node-type-loopback nodes as a workaround.

The configuration file `lab10_uni_path.conf` extends `lab10_nodes.conf` with a path section.
This example reads samples from node `rpi-1` and forwards them immediately to node `rtds-1`.

@includelineno node/etc/labs/lab10_path_uni.conf

### A path with multiple destinations

A path can have multiple destinations by using an array for the `out` setting.
This example reads samples from node `rtds-1`, duplicates them and forwards them immediately to nodes `rpi-1` and `rpi-2`.

@includelineno node/etc/labs/lab10_path_multiple_destinations.conf

### A path with a hook

Sometimes we want to filter and/or manipulate samples which are processes by a path.
To do so, we can attach __hook__ functions to a path.
These hook functions are called for every batch of samples which is processed by the pass.
This examples uses the `print` hook to display all forwarded samples on `stdout` of the console.

@includelineno node/etc/labs/lab10_path_hook.conf

### A bidirectional path

In a last example we demonstrate a bi-directional path by using multiple entries in the `paths` section.

@includelineno node/etc/labs/lab10_path_bidir.conf
