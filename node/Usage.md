# Usage {#node-usage}

VILLASnode comes with a couple of tools to test and debug connectivity and configurations.

### villas

All VILLASnode tools are available as sub-commands to the `villas` wrapper:

@include node/usage/villas.txt

### villas node {#node-usage-node}

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas-node` daemon.
The folling usage information is provided when called like `villas-node -`:

@include node/usage/villas-node.txt

The server requires root privileges to:

 - Enable the realtime FIFO scheduler
 - Increase the task priority
 - Configure the network emulator (@ref node-netem)
 - Change the SMP affinity of threads and network interrupts

### villas pipe {#node-usage-pipe}

The `pipe` sub-command allows to read and write samples from `stdin` / `stdout` streams.

@include node/usage/villas-pipe.txt

### villas signal {#node-usage-signal}

The `signal` sub-command is a signal generator which writes samples to `stdout`.
This command can be combined with the `pipe` sub-command.

@include node/usage/villas-signal.txt

### villas hook {#node-usage-hook}

The `hook` sub-command can be used to test filter / process hook functions.

@include node/usage/villas-hook.txt

### villas convert {#node-usage-convert}

The `convert` sub-command can be used to convert between different @ref node-formats.

@include node/usage/villas-convert.txt

### villas test-rtt {#node-usage-test-rtt}

@include node/usage/villas-test-rtt.txt

### villas test-cmp {#node-usage-test-cmp}

@include node/usage/villas-test-cmp.txt

### villas test-config {#node-usage-test-config}

The `villas test-config tool tests the syntax and validity of a VILLASnode configuration file.

@include node/usage/villas-test-config.txt

### villas relay {#node-usage-relay}

The `villas relay tool starts a WebSocket server which relays messages between connected clients.
Based on the URL which clients use for their connection, seperate sessions can be opened.
The relay does not require configuration.

@include node/usage/villas-relay.txt

### `villas shmem {#node-usage-shmem}

The `villas shmem` is a simple example tool to test the @ref node-type-shmem node-type for inter process communication.

@include node/usage/villas-shmem.txt
