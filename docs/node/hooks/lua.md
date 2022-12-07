---
hide_table_of_contents: true
---

# Lua scripting

The `lua` hook allows for the evaluation arbitrary Lua expressions.

Take a look at some example Lua scripts used by this hook here:
https://github.com/VILLASframework/node/tree/master/lua/hooks

## Prerequisites

This hook requires [Lua](https://www.lua.org/) (>= 5.1).

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/lua.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/lua" />

## Example

``` url="external/node/etc/examples/hooks/lua.conf" title="node/etc/examples/hooks/lua.conf"
@include "hook-nodes.conf"

stats = 1

paths = (
	{
		in = "signal_node"
		out = "file_node"

		hooks = (
			{
				type = "lua"

				# Enables or disables the use of signal names in the process() function
				# of the Lua script. If disabled, numeric indices will be used.
				use_names = true

				# The Lua hook will pass the complete hook configuration to the prepare()
				# function. So you can add arbitrary settings here which are then
				# consumed by the Lua script.
				some_setting = "Hello World"
				this = {
					is = {
						nested = 1234
						bool_val = true
					}
				}

				# Script mode: we provide a Lua script containing functions
				#              for the individual hook points
				# Define some or all of the following functions in your Lua script:
				#
				#   prepare(cfg)    Called during initialization with a Lua table which contains
				#                   the full hook configuration
				#   start()         Called when the node/path is started
				#
				#   stop()          Called when the node/path is stopped
				#
				#   restart()       Called when the node/path is restarted.
				#                   Falls back to stop() + start() if absent.
				#
				#   process(smp)    Called for each sample which is being processed.
				#                   The sample is passed as a Lua table with the following
				#                   fields:
				#                      - sequence     The sequence number of the sample.
				#                      - flags        The flags field of the sample.
				#                      - ts_origin    The origin timestamp as a Lua table containing
				#                                     the following keys:
				#                                         0: seconds
				#                                         1: nanoseconds
				#                      - ts_received  The receive timestamp a Lua table containing
				#                                     the following keys:
				#                                         0: seconds
				#                                         1: nanoseconds
				#                      - data         The sample data as a Lua table container either
				#                                     numeric indices or the signal names depending
				#                                     on the 'use_names' option of the hook.
				#
				#   periodic()      Called periodically with the rate of the global 'stats' option.
				script = "../lua/hooks/test.lua"

				# Expression mode: We provide a mangled signal list including Lua expressions
				signals = (
			 		{ name = "sum", type="float", unit = "V", expression = "smp.data.square * 10" },

					# You can access any global variable set by the script
					{ name = "sequence", type="float", unit = "V", expression = "global_var" },

					# Here we set a global variable from the periodic handler
					{ name = "temp_aachen", type="float", unit = "°C", expression = "temp_aachen" },

					# We can refer to the current time the global Lua variable 't'
					{ name = "sum", type="float", unit = "V", expression = "math.sin(2 * math.pi * f * t)" },

					{ name = "random", expression = "smp.data.random" }
			 	)
			},
			{
				type = "print"
			}
		)
	}
)
```

## Example Lua script

``` url="external/node/lua/hooks/test.lua" title="node/lua/hooks/test.lua"
-- Install with: luarocks install lunajson luasockets

json = require 'lunajson'
http = require 'socket.http'

------------------------ Constants -------------------------
Reason = {
	OK = 0,
	ERROR = 1,
	SKIP_SAMPLE = 2,
	STOP_PROCESSING = 3
}

SampleFlags = {
	HAS_TS_ORIGIN   = 1,      -- "(1 <<  1)"    Include origin timestamp in output.
	HAS_TS_RECEIVED = 2,      -- "(1 <<  2)"    Include receive timestamp in output.
	HAS_OFFSET      = 4,      -- "(1 <<  3)"    Include offset (received - origin timestamp) in output.
	HAS_SEQUENCE    = 8,      -- "(1 <<  4)"    Include sequence number in output.
	HAS_DATA        = 16,     -- "(1 <<  5)"    Include values in output.
	HAS_ALL         = 15,     -- "(1 <<  6) -1" Enable all output options.

	IS_FIRST        = 65536,  -- "(1 << 16)"    This sample is the first of a new simulation case
	IS_LAST         = 131072  -- "(1 << 17)"    This sample is the last of a running simulation case
}


-------------------------- Config --------------------------
city = 'Aachen'

--------------------- Global Variables ---------------------
f = 1           -- in Hz
t = nil         -- in seconds
t_start = nil   -- in seconds
temp_aachen = 0 -- in deg Celsius

function prepare(cfg)
	info("Preparing test_hook")

	info("Some setting: ", cfg.some_setting)
	info("Some other setting: ", cfg.this.is.nested)

	my_global_var = 1337
end


function start()
	info("Starting test_hook")

	info("Global var: ", my_global_var)

	info("This is a message with severity info")
	warn("This is a message with severity warn")
	error("This is a message with severity error")
	debug("This is a message with severity debug")

	t_start = socket.gettime()
end


function stop()
	info("Stopping test_hook")
end


function restart()
	info("Restarted test_hook")
end


function process(smp)
	info("Process test_hook")	

	if smp.sequence == 1 then
		dump_sample(smp)
	end

	-- We can adjust signal values inline
	smp.data.square = smp.data.square * 10

	-- Example for value limiter
	if smp.data.random > 10 then
		smp.data.random = 10
	elseif smp.data.random < -10 then
		smp.data.random = -10
	end

	global_var = smp.sequence

	-- Updating time (references in signal expression list of VILLASnode config)
	t = socket.gettime() - t_start

	if smp.sequence % 2 == 0 then
		return Reason.SKIP_SAMPLE
	elseif smp.sequence >= 200 then
		return Reason.ERROR
	end

	return Reason.OK
end



function periodic()
	info("Periodic test_hook")

	local body, statusCode, headers, statusText = http.request('https://wttr.in/' .. city .. '?format=j1')

	weather = json.decode(body)

	temp_aachen = tonumber(weather.current_condition[1].temp_C)

	info(string.format('Temperature in %s is %d °C', city, temp_aachen))
end


function dump_sample(smp)
	info("  Sequence:    ", smp.sequence)
	info("  Flags:       ", smp.flags)
	info("  TS origin:   ", string.format("%d.%09d", smp.ts_origin[0], smp.ts_origin[1]))
	info("  TS received: ", string.format("%d.%09d", smp.ts_received[0], smp.ts_received[1]))
	info("  Data:")
	for key, value in pairs(smp.data) do
		info("   " .. key .. ": " .. value)
	end
end
```
