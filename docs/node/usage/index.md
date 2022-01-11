# Usage {#node-usage}

VILLASnode comes with a couple of tools to test and debug connectivity and configurations.

## villas

All VILLASnode tools are available as sub-commands to the `villas` wrapper:

``` url="generated/node/usage/villas.txt" title="generated/node/usage/villas.txt"
Usage: villas [TOOL]
  TOOL     is one of api|conf2json|convert|ctl|cumulative-dist|extract-rtt|file-filter|file-merge|graph|hook|node|pipe|relay|shmem|signal|test-cmp|test-config|test-rtt|zmq-keygen

For detailed documentation, please see: 'villas node'
  http://villas.fein-aachen.org/doc/

13:24:11 info node: This is VILLASnode v0.11.0-5c666fb-debug (built on Feb 23 2021, 02:34:46)
13:24:11 info signals: Initialize subsystem
 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

### Subcommands

- [`villas node`](villas-node.md)
- [`villas relay`](villas-relay.md)
- [`villas pipe`](villas-pipe.md)
- [`villas graph`](villas-graph.md)
- [`villas signal`](villas-signal.md)
- [`villas hook`](villas-hook.md)
- [`villas convert`](villas-convert.md)
- [`villas test`](villas-test.md)
- [`villas zmq-keygen`](villas-zmq-keygen.md)
- [`villas conf2json`](villas-conf2json.md)
