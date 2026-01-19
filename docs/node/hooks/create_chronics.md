---
hide_table_of_contents: true
---

# Create Chronics

The `create_chronics` hook processes CSV files containing load nad generator data to create chronics files for power grid simulations. 
It reads normalized active and reactive power values from Load and SGen CSV files, maps them to buses given in a grid configuration file and outputs 
formatted CSV files (optionally compressed with bz2 format).

## Implementation

The source code of the hook is available here: 
https://github.com/VILLASframework/node/blob/hook-timeseries-chronix-conversion/lib/hooks/create_chronics.cpp

## Example 

``` url="external/node/etc/examples/hooks/create_chronics.conf" title="node/etc/examples/hooks/create_chronics.conf"
nodes = {
    file_node = {
        type = "file"
        format = {
        type = "csv"
        separator = ","
        delimiter = "\n"
        skip_first_line = false
        header = true
        }
        uris = ("./Load1.csv", "./SGen.csv")
        uri = "test_uri"
        in = {
            read_mode = "all"
        }
        hooks = (
            {
                type = "create_chronics"
                    loads_dir = "./"
                    sgens_dir = "./"
                    grid = "./grid_file.json"
                    output = "./test_output"
                    round_decimals = 3
                    compress = true
            }
        )
    },
    dummy_node = {
        type = "file"
        format = "csv"
        uri = "dummy"
        out = {

        }
    }
}

paths = (
    {
        in = "file_node",
        out = "dummy_node"

    }
)
```


