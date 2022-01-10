# villas signal

The `villas signal` command is a signal generator which writes samples to `stdout`.
This command can be combined with the [`villas pipe` command](villas-pipe.md) to build more complex pipelines.
Please note that we recommand to use the [`villas node` daemon](villas-node.md) for more production setups as it is more performant and allows for an easier configuration via [paths](../config/paths.md) .

# Usage

``` url="generated/node/usage/villas-signal.txt" title="generated/node/usage/villas-signal.txt"
Usage: villas-signal [OPTIONS] SIGNAL
  SIGNAL   is on of the following signal types:
    mixed
    random
    sine
    triangle
    square
    ramp
    constants
    counter

  OPTIONS is one or more of the following options:
    -d LVL  set debug level
    -f FMT  set the format
    -v NUM  specifies how many values a message should contain
    -r HZ   how many messages per second
    -n      non real-time mode. do not throttle output.
    -F HZ   the frequency of the signal
    -a FLT  the amplitude
    -D FLT  the standard deviation for 'random' signals
    -o OFF  the DC bias
    -l NUM  only send LIMIT messages and stop

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>```
