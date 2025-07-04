# villas test-*

VILLASnode provides a collection of utilities for testing its own functionality.
Most of them are used by the integration test suite.

# villas test-rtt

## Usage

``` url="generated/node/usage/villas-test-rtt.txt" title="villas-test-rtt --help"
Usage: villas-test-rtt [OPTIONS] CONFIG NODE
  CONFIG  path to a configuration file
  NODE    name of the node which shoud be used
  OPTIONS is one or more of the following options:
    -c CNT  send CNT messages
    -f FD   use file descriptor FD for result output instead of stdout
    -b BKTS number of buckets for histogram
    -w WMUP duration of histogram warmup phase
    -h      show this usage information
    -V      show the version of the tool

 v0.11.0-56c966f-debug (built on Mar 14 2022 16:07:12)
 Copyright 2014-2021, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```

# villas test-cmp

The `villas test-cmp` command compares two files containing sample data for equality.

## Usage

``` url="generated/node/usage/villas-test-cmp.txt" title="generated/node/usage/villas-test-cmp.txt"
Usage: villas-test-cmp [OPTIONS] FILE1 FILE2 ... FILEn
  FILE     a list of files to compare
  OPTIONS is one or more of the following options:
    -d LVL  adjust the debug level
    -e EPS  set epsilon for floating point comparisons to EPS
    -v      ignore data values
    -T      ignore timestamp
    -s      ignore sequence no
    -f FMT  file format for all files
    -t DT   the data-type format string
    -h      show this usage information
    -V      show the version of the tool

Return codes:
  0   files are equal
  1   file length not equal
  2   sequence no not equal
  3   timestamp not equal
  4   number of values is not equal
  5   data is not equal

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>```

# villas test-config

The `villas test-config` command tests the syntax and validity of a VILLASnode configuration file.

## Usage

``` url="generated/node/usage/villas-test-config.txt" title="generated/node/usage/villas-test-config.txt"
Usage: villas-test-config [OPTIONS] CONFIG
  CONFIG is the path to an optional configuration file
  OPTIONS is one or more of the following options:
    -d LVL  set debug level
    -V      show version and exit
    -c      perform plausibility checks on config
    -D      dump config in JSON format
    -h      show usage and exit

 v0.11.0-56c966f-debug (built on Mar 14 2022 16:07:12)
 Copyright 2014-2021, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```
