---
hide_table_of_contents: true
---

# Functional Mockup Unit (FMU) 

The `fmu` node-type can be used to control and communicate with an existing fmu model and step through its simulation through VILLASnode. 

## Prerequisites 

This node-type depends on the availability of the FMI3.0 specified C API ([fmi-library](https://github.com/modelon-community/fmi-library.git)). Please note that this node works only with FMU models implemented with FMI 3.0. 

## Implementation 

The source code is available here: 
https://github.com/VILLASframework/node/blob/node-fmu/lib/nodes/fmu.cpp

The implementation consists of interface abilities with Co-Simulation type of simulators, specificaly [`Basic Co-Simulation`](https://fmi-standard.org/docs/3.0.2/#_basic_co_simulation) and [`Early Return`](https://fmi-standard.org/docs/3.0.2/#_early_return).

## Configuration {#config}

Every `fmu` node can be considered as a gateway for a single model. Multiple models can be interconnected by configuring them as individual nodes and connected through `paths`.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/fmu" />

## Example 

``` url="external/node/etc/examples/nodes/fmu.conf"  title="node/etc/examples/nodes/fmu.conf"
odes = {
    file_output = {
        type = "file"
        # format = "csv"
        uri = "/workspaces/node/fmu_temp/output.dat"
        out = {

        }
    },

    signal_node = {
        type = "signal.v2"
        rate = 100.0
        realtime = true

        limit = 100

        in = {
            signals = (
                { name = "sine1",   signal = "sine",   amplitude = 1, frequency = 100   },
                # { name = "in2",   signal = "constant", amplitude = 1  },
            )
        }
    },
    fmu_node = {
        type = "fmu"
        # Path to fmu file
        fmu_path = "/workspaces/node/fmu_temp/asine.fmu"
        fmu_unpack_path = "/workspaces/node/fmu_temp/fmu_asine"
        fmu_writefirst = true
        stopTime = 10.0
        startTime = 0.0
        stepSize = 0.2

        in = {
            signals = (
                {name = "In1", type = "float"}
            )
        }

        out = {
            signals = (
                {name = "Out1", type = "float"},
            )
        }
    }
}

paths = (
    {
        in = "signal_node",
        out = "fmu_node"
    },
    {
        in = "fmu_node",
        out = "file_output"
    },
)
```