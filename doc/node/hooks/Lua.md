# Lua scripting {#node-hook-type-lua}

The `lua` hook allows for the evaluation arbitrary Lua expressions.

Take a look at some example Lua scripts used by this hook here:
https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/lua/hooks

# Prerequisites {#node-hook-type-lua-prereq}

This hook requires [Lua](https://www.lua.org/) (>= 5.1).

# Implementation {#node-hook-type-lua-implementation}

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/lua.cpp

# Configuration {#node-config-hook-lua}

## use_names (boolean) = true {#node-config-hook-lua-use-names}

Enables or disables the use of signal names in the `process()` Lua function.
If disabled, numeric indices will be used.

## script (path) = undefined {#node-config-hook-lua-script}

Provide the path to a Lua script containing functions for the individual hook points.
Define some or all of the following functions in your Lua script:

### prepare(cfg)

Called during initialization with a Lua table which contains the full hook configuration.

### start()

Called when the associated node or path is started

### stop()

Called when the associated node or path is stopped

### restart()

Called when the associated node or path is restarted.
Falls back to `stop()` + `start()` if absent.

### process(smp)

Called for each sample which is being processed.
The sample is passed as a Lua table with the following fields:

- sequence     The sequence number of the sample.
- flags        The flags field of the sample.
- ts_origin    The origin timesamp as a Lua table containing
               the following keys:
                   0: seconds
                   1: nanoseconds
- ts_received  The receive timestamp a Lua table containing
               the following keys:
                   0: seconds
                   1: nanoseconds
- data         The sample data as a Lua table container either
               numeric indices or the signal names depending
               on the 'use_names' option of the hook.

### periodic()

Called periodicalled with the rate of @ref node-config-stats.

## signals (list of objects) {#node-config-hook-lua-signals}

A definition of signals which this hook will emit.

Here a list of signal definitions like @ref node-config-node-signals is excpected.

### signals.expression {#node-config-hook-lua-use-names}

An arbitrary Lua expression which will be evaluated and used for the value of the signal.

Note you can access the current sample using the global Lua variable `smp`.

### Arbitrary additional options {#node-config-hook-lua-arbitrary}

The Lua hook will pass the complete hook configuration to the `prepare()` Lua function.
So you can add arbitrary settings here which are then consumed by the Lua script.

# Example {#node-hook-type-lua-example}

@include node/etc/examples/hooks/lua.conf

# Example Lua script {#node-hook-type-lua-example-script}

@include node/lua/hooks/test.lua
