# Tools {#node-usage}

VILLASnode comes with a couple of tools to test and debug connectivity and configurations.
All VILLASnode tools are available as subcommands to the `villas` wrapper:
 
### `villas node`

Starts the simulator to simulator server. The server acts as a central gateway to forward simulation data.

The core of VILLASnode is the `villas-node` daemon.
The folling usage information is provided when called like `villas-node --help`;

```
Usage: villas-node [CONFIG]
  CONFIG is the path to an optional configuration file
         if omitted, VILLASnode will start without a configuration
         and wait for provisioning over the web interface.

Supported node types:
 - file        : support for file log / replay node type
 - cbuilder    : RTDS CBuilder model
 - socket      : BSD network sockets
 - fpga        : VILLASfpga PCIe card (libxil)
 - ngsi        : OMA Next Generation Services Interface 10 (libcurl, libjansson)
 - websocket   : Send and receive samples of a WebSocket connection (libwebsockets)

Supported hooks:
 - restart     : Call restart hooks for current path
 - print       : Print the message to stdout
 - decimate    : Downsamping by integer factor
 - fix_ts      : Update timestamps of sample if not set
 - skip_first  : Skip the first samples
 - drop        : Drop messages with reordered sequence numbers
 - convert     : Convert message from / to floating-point / integer
 - shift       : Shift the origin timestamp of samples
 - ts          : Update timestamp of message with current time
 - stats       : Collect statistics for the current path
 - stats_send  : Send path statistics to another node

Supported API commands:
 - nodes       : retrieve list of all known nodes
 - config      : retrieve current VILLASnode configuration
 - reload      : restart VILLASnode with new configuration
```

The server requires root privileges for:

 - Enable the realtime FIFO scheduler
 - Increase the task priority
 - Configure the network emulator (netem)
 - Change the SMP affinity of threads and network interrupts

### `villas pipe`

The `pipe` subcommand allows to read and write samples to `stdin` / `stdout`.

    Usage: villas-pipe CONFIG [-r] NODE
      CONFIG  path to a configuration file
      NODE    the name of the node to which samples are sent and received from
      -r      swap read / write endpoints)

### `villas signal`

The `signal` subcommand is a signal generator which writes samples to `stdout`.
This command can be combined with the `pipe` subcommand.

    Usage: villas-signal SIGNAL [OPTIONS]
      SIGNAL   is on of: 'mixed', 'random', 'sine', 'triangle', 'square', 'ramp'
      -v NUM   specifies how many values a message should contain
      -r HZ    how many messages per second
      -f HZ    the frequency of the signal
      -a FLT   the amplitude
      -d FLT   the standard deviation for 'random' signals
      -l NUM   only send LIMIT messages and stop

### `villas test`

    Usage: villas-test CONFIG TEST NODE [ARGS]
      CONFIG  path to a configuration file
      TEST    the name of the test to execute: 'rtt'
      NODE    name of the node which shoud be used
 
### `villas fpga`

    Usage: ./fpga CONFIGFILE CMD [OPTIONS]
       Commands:
          tests      Test functionality of VILLASfpga card
          benchmarks Do benchmarks
    
       Options:
          -d    Set log level

## Examples

 1. Start server:

    $ villas node etc/example.conf

 2. Receive/dump data to file

    $ villas pipe etc/example.conf node_name > dump.csv

 3. Replay recorded data:

    $ villas pipe etc/example.conf -r node_name < dump.csv

 4. Send random generated values:

    $ villas signal random 4 100 | villas pipe etc/example.conf destination_node

 5. Test ping/pong latency:

    $ villas test latency etc/example.conf test_node