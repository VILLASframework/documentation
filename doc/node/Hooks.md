# Hook-types {#node-hook-types}

Sometimes forwarded sample data shall be modified or filtered.
VILLASnode supports _hooks_ for this purpose.
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

Hooks can be added to the processing pipeline in three places:

- **Node-read:**  Everytime a sample is received from a node
- **Node-write:** Everytime a sample is sent to a node
- **Path:**       Everytime a sample is processed within a path

Some hooks are built-in hooks which are by default enabled without a corresponding section in the configuration file.
Usually, built-in hooks have no configurable options.

Currently, the following _node-hook-types_ are supported:

| Type                            | Built-in  | Node-read | Node-write | Path | State      | Comment |
| :--                             | :--       | :--       | :--        | :--  | :--        | :-- |
| @subpage node-hook-type-average      |           | yes       | yes        | yes  | stable     | Calculate average over some signals |
| @subpage node-hook-type-cast         |           |           |            |      | stable     | Cast signals types |
| @subpage node-hook-type-decimate     |           | yes       | yes        | yes  | stable     | Downsamping by integer factor |
| @subpage node-hook-type-dp           |           | yes       | yes        | yes  | alpha      | Transform to/from dynamic phasor domain |
| @subpage node-hook-type-drop         | yes       | yes       |            |      | stable     | Drop messages with reordered sequence numbers |
| @subpage node-hook-type-dump         |           | yes       | yes        | yes  | stable     | Dump data to stdout |
| @subpage node-hook-type-ebm          |           |           |            |      | alpha      | Energy-based Metric |
| @subpage node-hook-type-fix          | yes       | yes       |            |      | stable     | Fix received data by adding missing fields |
| @subpage node-hook-type-jitter_calc  |           | yes       |            |      | stable     | Calc jitter, mean and variance of GPS vs NTP TS |
| @subpage node-hook-type-limit_rate   |           | yes       | yes        | yes  | stable     | Limit sending rate |
| @subpage node-hook-type-lua          |           | yes       | yes        | yes  | stable     | Lua scripting support |
| @subpage node-hook-type-restart      | yes       | yes       |            |      | stable     | Call restart hooks for current node |
| @subpage node-hook-type-scale        |           | yes       | yes        | yes  | stable     | Scale signals by a factor and add offset |
| @subpage node-hook-type-shift_seq    |           | yes       | yes        |      | stable     | Shift sequence number of samples |
| @subpage node-hook-type-shift_ts     |           | yes       | yes        |      | stable     | Shift timestamps of samples |
| @subpage node-hook-type-skip_first   |           | yes       | yes        | yes  | stable     | Skip the first samples |
| @subpage node-hook-type-stats        |           | yes       |            |      | stable     | Collect statistics for the current path |
| @subpage node-hook-type-ts           |           | yes       | yes        | yes  | stable     | Overwrite origin timestamp of samples with receive timestamp |
| @subpage node-hook-type-print        |           | yes       | yes        | yes  | stable     | Print the message to stdout |


## Writing custom hook functions

@todo This still needs to be written.
