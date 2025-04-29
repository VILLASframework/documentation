---
hide_table_of_contents: true
---

# OpenDSS

[OpenDSS](https://sourceforge.net/projects/electricdss/) is an electric power distribution system simulator (DSS) designed to support distributed energy resource (DER) grid integration and grid modernization.
This node-type runs OpenDSS within VILLASnode and enables VILLASnode to exchange data with OpenDSS. 

## Prerequisites

This node-type requires OpenDSS shared library. 
The documentation for compiling the library can be found in the [OpenDSS documentation](https://opendss.epri.com/OpenDSSC.html).
Alternatively, the script found at `packaging/deps.sh` can be used. Please refer to the [installation document](../installation.md).

## Implementation

The Implementation of this node type is limited to only sending the data to set the values of certain element including:

 - **Load:** Voltage(kV), Active Power(kW), Apparent Power(kVA), Power Factor(Pf)
 - **Generator:** Voltage(kV), Active Power(kW), Apparent Power(kVA), Power Factor(Pf)
 - **ISource:** Current(Amps), Phase angle(AngleDeg), Frequency(f)

For the output, VILLASnode will read the data from a monitor element for each time step.
The input and output data needed to be transported by [`path`](../config/paths.md) from/to other nodes.

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/opendss.cpp

## Configuration {#config}

For input data the name, element type and type of data are needed to be provived.
However, for output data only the name of the monitor element is needed.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/opendss" />

## Example

``` url="external/node/etc/examples/nodes/opendss.conf" title="node/etc/examples/nodes/opendss.conf"
nodes = {
    opendss_node = {
        type = "opendss"

        # Path to OpenDSS file
        file_path = "OpenDSS_file/sample.DSS"

        # Example input configuration. Input data will be used to set Active power and power factor
        # of load element name load1 and Active power of the generator element name gen1.
        # Element name are deleared in OpenDSS file.
        # Available input type and data:
        #   - load:         kV, kW, kVA, Pf
        #   - generator:    kV, kW, kVA, Pf
        #   - isource:      Amps, AngleDeg, f
        in = {
            list = (
                {name = "load1", type = "load", data = ("kW", "Pf")},
                {name = "gen1", type = "generator", data = ("kW")}
            )
        }

        # Example output configuration. Output data will be read from monitor name load1_power and load1_v.
        # Monitor name are declared in OpenDSS file.
        out = {
            list = ["load1_power", "load1_v"]
        }
    }

    udp_node = {
        type = "socket"

        layer = "udp"

        format = "villas.human"

        in = {
            address = "*:12000"
        }
        out = {
            address = "127.0.0.1:12001"
        }
    }

    file_node1 = {
        type = "file"

        uri = "load.dat"

        in = {
            epoch_mode = "direct"
            epoch = 10
            rate = 2
            buffer_size = 0
        }
    }
}

paths = (
    {
        # Get input for file node type
        in = "file_node1"
        out = "opendss_node"
        hooks = ( { type = "print" } )
    },
    {
        # Output to udp node type
        in = "opendss_node"
        out = "udp_node"
        hooks = ( { type = "print" } )
    }
)
```