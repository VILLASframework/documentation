# Tools {#node-usage}

VILLASnode comes with a couple of tools to test and debug connectivity and configurations.

### `villas`

All VILLASnode tools are available as sub-commands to the `villas` wrapper:

```
$ villas
Usage: villas [TOOL]
  TOOL     is one of fpga|hook|node|pipe|signal|test-cmp|test-rtt|test-shmem

For detailed documentation, please run 'villas node'
 and point your web browser to http://localhost:80

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### `villas node`

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas-node` daemon.
The folling usage information is provided when called like `villas-node -`:

```
$ villas node -h
Usage: villas-node [CONFIG]
  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node types:
 - file        : support for file log / replay node type
 - cbuilder    : RTDS CBuilder model
 - shmem       : POSIX shared memory interface with external processes
 - socket      : BSD network sockets
 - fpga        : VILLASfpga PCIe card (libxil)
 - ngsi        : OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - websocket   : Send and receive samples of a WebSocket connection (libwebsockets)

Supported hooks:
 - restart     : Call restart hooks for current path
 - print       : Print the message to stdout
 - stats       : Collect statistics for the current path
 - decimate    : Downsamping by integer factor
 - fix_ts      : Update timestamps of sample if not set
 - skip_first  : Skip the first samples
 - stats_send  : Send path statistics to another node
 - drop        : Drop messages with reordered sequence numbers
 - convert     : Convert message from / to floating-point / integer
 - ts          : Overwrite origin timestamp of samples with receive timestamp
 - shift_seq   : Shift sequence number of samples
 - map         : Remap values and / or add header, timestamp values to the sample
 - shift_ts    : Shift timestamps of samples

Supported API commands:
 - capabilities: get capabiltities and details about this VILLASnode instance
 - nodes       : retrieve list of all known nodes
 - config      : retrieve current VILLASnode configuration
 - restart     : restart VILLASnode with new configuration

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

The server requires root privileges for:

 - Enable the realtime FIFO scheduler
 - Increase the task priority
 - Configure the network emulator (netem)
 - Change the SMP affinity of threads and network interrupts

### `villas pipe`

The `pipe` sub-command allows to read and write samples to `stdin` / `stdout`.

```
$ villas pipe
villas pipe
Usage: villas-pipe CONFIG NODE [OPTIONS]
  CONFIG  path to a configuration file
  NODE    the name of the node to which samples are sent and received from
  OPTIONS are:
    -d LVL  set debug log level to LVL
    -x      swap read / write endpoints
    -s      only read data from stdin and send it to node
    -r      only read data from node and write it to stdout

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### `villas signal`

The `signal` sub-command is a signal generator which writes samples to `stdout`.
This command can be combined with the `pipe` sub-command.

```
$ villas signal
Usage: villas-signal SIGNAL [OPTIONS]
  SIGNAL   is on of: 'mixed', 'random', 'sine', 'triangle', 'square', 'ramp'
  -d LVL   set debug level
  -v NUM   specifies how many values a message should contain
  -r HZ    how many messages per second
  -n       non real-time mode. do not throttle output.
  -f HZ    the frequency of the signal
  -a FLT   the amplitude
  -D FLT   the standard deviation for 'random' signals
  -l NUM   only send LIMIT messages and stop

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### `villas hook`

The `hook` sub-command can be used to test filter / process hook functions.

```
$ villas hook
Usage: villas-hook [OPTIONS] NAME [PARAM]
  PARAM     a string of configuration settings for the hook
  OPTIONS are:
    -h      show this help
    -d LVL  set debug level to LVL
    -v CNT  process CNT samples at once
  NAME      the name of the hook function

The following hook functions are supported:
 - restart     : Call restart hooks for current path
 - print       : Print the message to stdout
 - stats       : Collect statistics for the current path
 - decimate    : Downsamping by integer factor
 - fix_ts      : Update timestamps of sample if not set
 - skip_first  : Skip the first samples
 - stats_send  : Send path statistics to another node
 - drop        : Drop messages with reordered sequence numbers
 - convert     : Convert message from / to floating-point / integer
 - ts          : Overwrite origin timestamp of samples with receive timestamp
 - shift_seq   : Shift sequence number of samples
 - map         : Remap values and / or add header, timestamp values to the sample
 - shift_ts    : Shift timestamps of samples

Example:  villas-signal random | villas-hook skip_first seconds=10

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### `villas test-rtt`

```
$ villas test-rtt
Usage: villas-test-rtt CONFIG NODE [ARGS]
  CONFIG  path to a configuration file
  NODE    name of the node which shoud be used
  ARGS    the following optional options:
   -c CNT  send CNT messages
   -f FD   use file descriptor FD for result output instead of stdout
   -l LOW  smallest value for histogram
   -H HIGH largest value for histogram
   -r RES  bucket resolution for histogram
   -h      show this usage information

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### `villas test-cmp`

```
$ villas test-cmp
Usage: villas-test-cmp FILE1 FILE2 [OPTIONS]
  FILE1    first file to compare
  FILE2    second file to compare against
  OPTIONS  the following optional options:
   -h      print this usage information
   -d LVL  adjust the debug level
   -e EPS  set epsilon for floating point comparisons to EPS

Return codes:
  0   files are equal
  1   file length not equal
  2   sequence no not equal
  3   timestamp not equal
  4   number of values is not equal
  5   data is not equal

VILLASnode v0.2-9821365-release (built on May  3 2017 14:42:59)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```