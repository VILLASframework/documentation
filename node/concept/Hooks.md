# Hooks {#node-concept-hook}

Hooks are simple callback functions which are called whenever a message is processed by a path.

There are several built-in hooks for:
  - collecting, show & reset statistics
  - drop reordered messages
  - verify message metadata
  - handle simulation restarts
  - remapping values of a sample
  - overwriting / updating timestamps
  - converting data-types
  - downsampling

But main goal of this mechanism is to provide extensibility for the end user.
Example applications for hooks might be:

 1. Filter sample values
 2. Manipulate sample values: FIR
 3. Transform sample values: FFT, DCT
 4. Update network emulation settings based on sample values

## Configuration

Each path or node is allowed to have multiple attached hook functions.

Those can be configured in the path and nodes sections using the `hooks` setting:

```
nodes = {
	input_node = {
		type = "socket"

		# Node settings here..

		hooks = (
			{
				type = "print",
				enabled = true,

				# Type specific options follow here...
			}
		)
	}
}

paths = (
	{
		in = [
			"input_node"
		],
		out = [
			"output_node"
		],

		hooks = (
			{
				type = "decimate",
				ratio = 10
			}
		)
	}
)
```

## Available hook functions

- @subpage node-hook-ts
- @subpage node-hook-fix_ts
- @subpage node-hook-drop
- @subpage node-hook-convert
- @subpage node-hook-print
- @subpage node-hook-stats_collect
- @subpage node-hook-stats_send
- @subpage node-hook-shift_ts
- @subpage node-hook-shift_seq
- @subpage node-hook-skip_first

## Writing custom hook functions

@todo This still needs to be written.
