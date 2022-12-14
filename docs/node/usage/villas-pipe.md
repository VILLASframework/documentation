---
sidebar_position: 2
---

# villas pipe

The `villas pipe` command allows to read and write samples from `stdin` / `stdout` streams.

# Usage

``` url="generated/node/usage/villas-pipe.txt" title="villas-pipe --help"
Usage: villas-pipe [OPTIONS] CONFIG NODE
  CONFIG  path to a configuration file
  NODE    the name of the node to which samples are sent and received from
  OPTIONS are:
    -f FMT           set the format
    -t DT            the data-type format string
    -o OPTION=VALUE  overwrite options in config file
    -x               swap read / write endpoints
    -s               only read data from stdin and send it to node
    -r               only read data from node and write it to stdout
    -T NUM           terminate after NUM seconds
    -L NUM           terminate after NUM samples sent
    -l NUM           terminate after NUM samples received
    -h               show this usage information
    -d               set logging level
    -V               show the version of the tool

 v0.11.0-56c966f-debug (built on Mar 14 2022 16:07:12)
 Copyright 2014-2021, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```
