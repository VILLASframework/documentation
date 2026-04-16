---
sidebar_position: 3
---

# villas chronics

The `villas chronics` command is a tool that can be used to process CSV files containing load and generator data to create chronics files for power grid simulations while using OpenDSS. 
It reads normalized active and reactive power values from `Load` and `SGen` CSV files, maps them to buses given through a grid configuration file and outputs formatted CSV files (optionally compressed in bz2 format).

# Usage

``` url="generated/node/usage/villas-signal.txt" title="villas-chronics --help"
Usage: villas-chronics config.json
  config.json can be as shown below: 

{
  "loads_dir": "/workspaces/node-main/input_files",
  "sgens_dir": "/workspaces/node-main/input_files",
  "grid": "/workspaces/node-main/input_files/grid_file.json",
  "output": "/workspaces/node-main/output_files",
  "compress": true,
}
```
