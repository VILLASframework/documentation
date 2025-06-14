---
hide_table_of_contents: true
---

# Modbus

The `modbus` node-type uses [libmodbus](https://libmodbus.org/) to communicate to devices via Modbus over the RTU or TCP transports.

## Prerequisites

This node-type requires [libmodbus](https://libmodbus.org/) (>= 3.1.0).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/modbus.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/modbus" />

## Example

``` url="external/node/etc/examples/nodes/modbus.conf" title="node/etc/examples/nodes/modbus.conf"
nodes = {
	modbus_node = {
		type = "modbus"

		# Required transport type. Can be either "rtu" or "tcp"
		transport = "tcp"

		# Optional timeout in seconds when waiting for responses from a modbus server.
		# Default is 1.0.
		response_timeout = 1.0


		#
		# Settings for transport = "tcp".
		#

		# Required remote IP address.
		remote = "127.0.0.1"

		# Optional remote port.
		# Default is 502.
		port = 502


		#
		# Settings for transport = "rtu"
		#

		# Required device file.
		device = "/dev/ttyS0"

		# Required baudrate.
		baudrate = 9600

		# Required parity. One of "none", "even" and "odd"
		parity = "none"

		# Required data bits. One of 5, 6, 7, 8
		data_bits = 5

		# Required stop bits. One of 1, 2
		stop_bits = 1

		# The modbus unit ID.
		# Required for transport = "rtu".
		# Optional for transport = "tcp".
		unit = 1

		# Optional polling rate for the modbus remote reads.
		# Defaults to 10.
		rate = 10

		in = {
			signals = (
				# A 32-bit IEEE 754 floating point value.
				# This spans 2 registers.
				{
					# Required type = "float".
					type = "float"

					# Required address of the lowest register.
					address = 0x50

					# Optional endianess for joining the 2 16-bit registers into a 32-bit value.
					# Defaults to "big".
					word_endianess = "big"

					# Optional endianess for the 2 bytes within a register.
					# Defaults to "big".
					byte_endianess = "big"

					# Optional scale that should be applied to the integer value.
					# Defaults to 1.
					scale = 10

					# Optional offset that should be applied to the integer value after scaling.
					# Defaults to 0.
					offset = 2
				},
				# A single bit within a register as a boolean value.
				{
					# Required type = "boolean".
					type = "boolean"

					# Required address of the register.
					address = 0x54

					# Required bit within the register.
					# Starting at 0.
					bit = 0
				},
				# An integer value.
				# This may span multiple registers.
				{
					# Required type = "integer".
					type = "integer"

					# Required address of the lowest register.
					address = 0x52

					# Optional number of registers that should be joined to form the value.
					# Defaults to 1.
					integer_registers = 1

					# Optional endianess for joining the 16-bit registers into a 32-bit value.
					# Defaults to "big".
					word_endianess = "big"

					# Optional endianess for the 2 bytes within a register.
					# Defaults to "big".
					byte_endianess = "big"
				},
				# An float value created by reading an integer and applying an optional offset and scale.
				# This may span multiple registers.
				{
					# Required type = "float".
					type = "float"

					# Required address of the lowest register.
					address = 0x52

					# Required number of registers that should be joined to form the value.
					# A "float" value without the "integer_registers" settings is considered an IEEE 754 float, spanning 2 registers.
					integer_registers = 1

					# Optional endianess for joining the 16-bit registers into a 32-bit value.
					# Defaults to "big".
					word_endianess = "big"

					# Optional endianess for the 2 bytes within a register.
					# Defaults to "big".
					byte_endianess = "big"

					# Optional scale that should be applied to the integer value.
					# Defaults to 1.
					scale = 10

					# Optional offset that should be applied to the integer value after scaling.
					# Defaults to 0.
					offset = 2
				}
			)
		}

		out = {
			signals = (
				# All register mappings described for "in" except for "boolean" are supported in the "out" signals.
				{
					type = "float"
					address = 0x50

					# Scale and offset a applied as attributes of the register that is written to.
					# This means the value written to "register" for a "signal" with "offset" and "scale" will be:
					#
					#   register = (signal - offset) / scale
					#
					# It is fairly common to specify a scale and offset for modbus registers in a device manual.
					# You should be able to plug those values into this configuration without conversion.
					scale = 10
					offset = 2
				},
			)
		}
	}
}
```
