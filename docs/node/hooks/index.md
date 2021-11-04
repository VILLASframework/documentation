---
sidebar_position: 1
sidebar_label: Overview
---

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
| [`average`](average.md)         |           | yes       | yes        | yes  | stable     | Calculate average over some signals |
| [`cast`](cast.md)               |           |           |            |      | stable     | Cast signals types |
| [`decimate`](decimate.md)       |           | yes       | yes        | yes  | stable     | Downsamping by integer factor |
| [`dp`](dp.md)                   |           | yes       | yes        | yes  | alpha      | Transform to/from dynamic phasor domain |
| [`drop`](drop.md)               | yes       | yes       |            |      | stable     | Drop messages with reordered sequence numbers |
| [`dump`](dump.md)               |           | yes       | yes        | yes  | stable     | Dump data to stdout |
| [`ebm`](ebm.md)                 |           |           |            |      | alpha      | Energy-based Metric |
| [`fix`](fix.md)                 | yes       | yes       |            |      | stable     | Fix received data by adding missing fields |
| [`jitter_calc`](jitter_calc.md) |           | yes       |            |      | stable     | Calc jitter, mean and variance of GPS vs NTP TS |
| [`limit_rate`](limit_rate.md)   |           | yes       | yes        | yes  | stable     | Limit sending rate |
| [`lua`](lua.md)                 |           | yes       | yes        | yes  | stable     | Lua scripting support |
| [`restart`](restart.md)         | yes       | yes       |            |      | stable     | Call restart hooks for current node |
| [`scale`](scale.md)             |           | yes       | yes        | yes  | stable     | Scale signals by a factor and add offset |
| [`shift_seq`](shift_seq.md)     |           | yes       | yes        |      | stable     | Shift sequence number of samples |
| [`shift_ts`](shift_ts.md)       |           | yes       | yes        |      | stable     | Shift timestamps of samples |
| [`skip_first`](skip_first.md)   |           | yes       | yes        | yes  | stable     | Skip the first samples |
| [`stats`](stats.md)             |           | yes       |            |      | stable     | Collect statistics for the current path |
| [`ts`](ts.md)                   |           | yes       | yes        | yes  | stable     | Overwrite origin timestamp of samples with receive timestamp |
| [`print`](print.md)             |           | yes       | yes        | yes  | stable     | Print the message to stdout |

## Writing custom hook functions

@todo This still needs to be written.
