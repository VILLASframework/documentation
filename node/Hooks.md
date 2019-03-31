# Hook-types {#hook-types}

Sometimes forwarded sample data shall be modified or filtered.
VILLASnode supports _hooks_ for this purpose.

Hooks can be added to the processing pipeline in three places:

- **Node-read:**  Everytime a sample is received from a node
- **Node-write:** Everytime a sample is sent to a node
- **Path:**       Everytime a sample is processed within a path

Some hooks are built-in hooks which are by default enabled without a corresponding section in the configuration file.
Usually, built-in hooks have no configurable options.

Currently, the following _hook-types_ are supported:

| Type                            | Built-in  | Node-read | Node-write | Path | State      | Comment |
| :--                             | :--       | :--       | :--        | :--  | :--        | :-- |
| @subpage hook-type-average      |           | yes       | yes        | yes  | stable     | Calculate average over some signals |
| @subpage hook-type-cast         |           |           |            |      | stable     | Cast signals types |
| @subpage hook-type-decimate     |           | yes       | yes        | yes  | stable     | Downsamping by integer factor |
| @subpage hook-type-dp           |           | yes       | yes        | yes  | alpha      | Transform to/from dynamic phasor domain |
| @subpage hook-type-drop         | yes       | yes       |            |      | stable     | Drop messages with reordered sequence numbers |
| @subpage hook-type-dump         |           | yes       | yes        | yes  | stable     | Dump data to stdout |
| @subpage hook-type-ebm          |           |           |            |      | alpha      | Energy-based Metric |
| @subpage hook-type-fix          | yes       | yes       |            |      | stable     | Fix received data by adding missing fields |
| @subpage hook-type-jitter_calc  |           | yes       |            |      | stable     | Calc jitter, mean and variance of GPS vs NTP TS |
| @subpage hook-type-limit_rate   |           | yes       | yes        | yes  | stable     | Limit sending rate |
| @subpage hook-type-restart      | yes       | yes       |            |      | stable     | Call restart hooks for current node |
| @subpage hook-type-scale        |           | yes       | yes        | yes  | stable     | Scale signals by a factor and add offset |
| @subpage hook-type-shift_seq    |           | yes       | yes        |      | stable     | Shift sequence number of samples |
| @subpage hook-type-shift_ts     |           | yes       | yes        |      | stable     | Shift timestamps of samples |
| @subpage hook-type-skip_first   |           | yes       | yes        | yes  | stable     | Skip the first samples |
| @subpage hook-type-stats        |           | yes       |            |      | stable     | Collect statistics for the current path |
| @subpage hook-type-ts           |           | yes       | yes        | yes  | stable     | Overwrite origin timestamp of samples with receive timestamp |
| @subpage hook-type-print        |           | yes       | yes        | yes  | stable     | Print the message to stdout |
