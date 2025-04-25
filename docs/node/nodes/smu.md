---
sidebar_label: SMU
hide_table_of_contents: true
---

# Synchronized Phasor Measurement Unit (SMU)

The `smu` node-type simplifies the collection of data because it can be parsed directly to other VILLASnode node-types or hooks. 
Usually, VILLASnode runs on a Raspberry Pi attached to a data acquistion unit. 
A very detailed description is available here [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7598136.svg)](https://doi.org/10.5281/zenodo.7598136).

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/smu.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/smu" />

## Example

``` url="external/node/etc/examples/nodes/smu.conf" title="node/etc/examples/nodes/smu.conf"
nodes = {
    smu = {
        type = "smu"
        signals = (
            { name = "ch1", type = "float"},
            { name = "ch2", type = "float"},
            { name = "signal3", type = "float"},
            { name = "signal4", type = "float"},
            { name = "signal5", type = "float"},
            { name = "signal6", type = "float"},
            { name = "signal7", type = "float"}
        )
        vectorize = 1000
        sample_rate = "FS_10kSPS"
        dumper = (
            { name = "ch1", path = "/tmp/ch1"},
            { name = "ch2", path = "/tmp/ch2"}
        )
    }

    file = {
        type = "file"
        format = "csv"
        uri = "./data.csv"
    }
}

paths = (
    {
        enabled = true
        #queuelen = 20000
        in = "smu"
        out = "file"
        hooks = (
            {
                type = "scale"
                scale = 0.000305185 #10/32767
                offset = 0 #1280
                signal = "ch1"
            },
            {
                type = "ip-dft-pmu"
                enabled = true
                estimation_range = 10.
                nominal_freq = 50.
                number_plc = 10.
                sample_rate = 10000
                dft_rate = 10
                window_type = "hann"
                signals = ["ch1"]
                angle_unit = "degree"
                timestamp_align = "center"
                add_channel_name = true
                phase_offset = 0
                frequency_offset = 0.0015
                amplitude_offset = 0
            }
        )
    }
)

```
