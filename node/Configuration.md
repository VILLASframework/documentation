# Configuration {#node-config}

The VILLASnode configuration consists of a a single file.

For a collection of example configuration files see: <https://git.rwth-aachen.de/VILLASframework/VILLASnode/tree/develop/etc>.

At the top level, the configuration file consists of these sections:

- Global
- Logging
- WebServer
- FPGAs
- Nodes
- Paths

# Global {#node-config-global}

The global section consists of some global configuration parameters:

## stats (float) {#node-config-stats}

Specifies the rate in which statistics about the actives paths will be periodically printed to the screen.

Setting this value to 5, will print 5 lines per second.

A line of includes information such as:

  - Source and Destination of path
  - Messages received
  - Messages sent
  - Messaged dropped

## affinity (integer) {#node-config-affinity}

Restricts the exeuction of the daemon to certain CPU cores.
This technique, also called 'pinning', improves the determinism of the server by isolating the daemon processes on exclusive cores.

## priority (integer) {#node-config-priority}

Adjusts the scheduling priority of the deamon processes.
By default, the daemon uses a real-time optimized FIFO scheduling algorithm.

## hugepages (integer) {#node-config-hugepages}

The number of hugepages which will be reservered by the system.

See: <https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt>

## name (string) = hostname {#node-config-name}

By default the `name` of a VILLASnode instance is equal to the hostname of the machine it is running on.
Some node types are using this name to identify themselves agains their remotes.
An example is the `ngsi` node type which adds a metadata attribute `source` to its updates.

# Log {#node-config-log}

```
log = {
	file = "/var/log/villas-node.log";
	level = 5;
	facilities = "socket,log,mem";	// log socket node-type, log and memory sub-system
}
```

## log.level (integer) {#node-config-log-level}

`log.level` expects a positive integer number which adjusts the verbosity of debug messages.
Use this with care! Producing a lot of IO might decrease the performance of the server.
Omitting this setting or setting it to zero will disable debug messages completely.

## log.file (path) {#node-config-log-file}

Write all log messages to a file.

## log.facilities (string) = "all" {#node-config-log-facilities}

`log.facilities` is a comma-separated expression which selects the active logging facilities.
Each of the facilities can be prefixed with an exclamation mark in order to exclude it.

Examples:

```
facilities = "nodes,!websocket";	// log all node-type but not the websocket node-type
facilities = "all,!nodes";	// log everything but not the node-types
facilities = "socket,log,mem";	// log socket node-type, log and memory sub-system
```

The following logging facilities are available:

| Facility		| Description |
|:-		|:- |
| `pool` 		| Memory Pool for fixed size allocations |
| `queue` 	| Multiple-producer / Multiple-consumer queue |
| `config` 	| Configuration parser |
| `hook` 		| Hook sub-system |
| `path` 		| Send / Receive path |
| `node` 		| Node-types |
| `mem` 		| Memory management |
| `web` 		| Web sub-system |
| `api` 		| Remote API |
| `log` 		| Logging sub-system |
| `vfio` 		| Virtual Function Input/Output sub-system for access to PCI devices |
| `pci` 		| PCI device detection |
| `xil` 		| Xilinx drivers for FPGA components |
| `tc` 		| Linux traffic control for network emulation |
| `if` 		| Linux network interfaces |
| `socket` 	| BSD Socket node-type |
| `file` 		| File node-type |
| `fpga` 		| VILLASfpga node-type |
| `ngsi` 		| FIWARE NGSI node-type |
| `websocket` 	| WebSocket node-type |
| `opal` 		| OPAL-RT node-type |

# HTTP / WebSocket server {#node-config-http}

```
http = {
	enabled = true,					# Do not listen on a port if false
	
	htdocs = "/villas/web/socket/",			# Root directory of internal webserver
	port = 80					# Port for HTTP connections
}
```

## http.enabled (boolean) = true {#node-config-http-enabled}

When set to `false` the VILLASnode daemon will not listen on a port for servering HTTP and WebSocket requests.

## http.htdocs (string: path) = "/usr/share/villas/node/web"  {#node-config-http-htdocs}

The location of of static files served by the HTTP / WebSocket server.

## http.port (integer)  = 80 {#node-config-http-port}

The TCP port number on which HTTP / WebSocket server.

# Nodes {#node-config-node}

The node section is a **directory** of nodes (clients) which are connected to the VILLASnode instance.
The directory is indexed by the name of the node:

```
nodes = {
	"sintef_node" = {
		type = "socket";
		...
	}
}
```

There are different type of nodes available. But all types have the following settings in common:

## type (string: "socket" | "fpga" | "file" | "ngsi" | "websocket" | "shmem") {#node-config-node-type}

`type` specifies the type of the node.

For a complete list of supported node-types run `villas node --help`.

In addition to the node settings described in this section, every node type has its own specific settings.
Take a look at the @ref node-types page for details.

## vectorize (integer) = 1 {#node-config-node-vectorize}

This setting allows to send multiple samples in a single message to the destination nodes.

The value of this setting determines how many samples will be combined into one packet.

**Important:** Please make sure that the value of this setting is smaller or equal to the `poolsize` setting of this path.

# Paths {#node-config-path}

The path section consists of a **list** of paths:

```
paths = [
    {
        in = "rtds",
        out = "broker",
        reverse = false,
        poolsize = 32,
        msgsize = 16,
        vectorize = 4,
        hook = [ "print", "ts" ]
    }
]
```

Every path can have the following settings:

## in, out (string: node-name) {#node-config-path-in-out}

The `in` and `out` settings expect the name of the source and destination node.

The `out` setting itself is allowed to be list of nodes.
This enables 1-to-n distribution of simulation data.

## enabled (boolean) {#node-config-path-enabled}

The optional `enabled` setting can be used to temporarily disable a path.
If omitted, the path is enabled by default.

## reverse (boolean) {#node-config-path-reverse}

By default, the path is unidirectional. Meaning, that it only forwards samples from the source to the destination.
Sometimes a bidirectional path is needed.
This can be accomplished by setting `reverse` to `true`.

## rate (float) {#node-config-path-rate}

**Important:** This feature is currently not working!

A non-zero value for this setting will change this path to an asynchronous mode.
In this mode VILLASnode will send with a fixed rate to all destination nodes.
It will always send the latest value it received, possible skipping values which have been received in between.
If `vectorize` is larger than 1, it will send the last `vectorize` samples at once.

**Important:** Please note that there is no correlation between the time of arrival and time of departure in this mode. It might increase the latency of this path by up to `1 / rate` seconds!

## poolsize (integer) {#node-config-path-poolsize}

Every path manages a circular buffer to keep a history of past samples. This setting specifies the size of this circular buffer.

**Important:** There are some hook functions (or the `vectorize` setting) which require a minimum poolsize (for example the finite-impulse-response `fir` hook).

## hook (list of strings) {#node-config-path-hook}

A list of hook functions which will be executed for this path.

Please consult the hook chapter of this documentation for more details.
