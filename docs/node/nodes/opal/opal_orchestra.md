---
hide_table_of_contents: true
sidebar_position: 1
---

# Orchestra

Orchestra is OPAL-RT's co-simulation framework for integrating custom code and external models.
More information about Orchestra can be found in the [OPAL-RT Wiki](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/505348099/Orchestra+I+O).

:::tip
Please familiarize yourself first with Orchestra using the [OPAL-RT Wiki](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/505348099/Orchestra+I+O) before attempting to use it with VILLASnode.
:::

## Prerequisites

- A OPAL-RT real-time simulator.
- 64-bit OPAL-RT Linux v3.4.1 or newer.
    - `libOpalOrchestra.so` & `RTAPI.h`
- One of:
    - RT-LAB v2025.1 or newer
    - HYPERSIM v2025.3 or newer

:::info
The RT-LAB and HYPERSIM versions above were validated. Other versions might work as well. Use at your own discretion.
:::

:::caution
Older 32-bit OPAL-RT targets running RHEL / CentOS operating systems are not supported.
:::

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/nodes/opal_orchestra.cpp

## Installation

Please refer to the [Lab 21](../../guides/lab21) for a detailed guide on how to install VILLASnode on an OPAL-RT Real-time target.

## Configuration {#config}

### Reference

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/opal_orchestra" />

## Example

``` url="external/node/etc/examples/nodes/opal_orchestra.conf" title="node/etc/examples/nodes/opal_orchestra.conf"
stats = 1

nodes = {
    domain1 = {
        type = "opal.orchestra"

        # Path  to the OPAL-RT Orchestra Data Defintion XML file (DDF).
        ddf = "orchestra.xml"

        # Enable to overwrite the DDF file.
        # This is useful when you want to generate the DDF file from the configuration file
        # for importing it into RT-LAB or HYPERSIM.
        ddf_overwrite = true

        # Orchestra domain name.
        domain = "domain1"

        # Connection timeout. In seconds.
        connect_timeout = "2s"

        # Define the delay to wait when using flag synchronisation (XHP).
        # This will call the system function usleep and free the CPU.
        # In micro-seconds.
        flag_delay = "5us"

        # Force the local Orchestra communication to be made with flag instead of semaphore when using an external communication process.
        # Define the delay to wait, this will call the system function usleep and free the CPU.
        # In micro-seconds.
        flag_delay_tool = "5us"
        skip_wait_to_go = false

        rate = 500.0;

        # The following parameters are used to generate the Orchestra DDF XML file.
        synchronous = false
        states = false
        multiple_publish_allowed = false

        connection = {
            # One of: local, remote or dolphin
            type = "local"

            # For 'local'
            extcomm = "udp";
            addr_framework = "10.168.13.5";
            port_framework = 10000
            core_framework = 0
            core_client = 0
            nic_framework = "eno2"
            nic_client = "eno1"

            # For 'remote'
            card = "test"
            pci_index = 0

            # For 'dolphin'
            node_id_framework = 0
            segment_id = 0
        }

        in = {
            hooks = (
                { type = "stats" },
                { type = "print" }
            )

            signals = (
                {
                    name = "pub_signal1"
                    type = "float"

                    orchestra_name = "pub_signal_float"
                    orchestra_type = "float64"
                    orchestra_index = 0
                },
                {
                    name = "pub_signal2"
                    type = "float"

                    orchestra_name = "pub_signal_float"
                    orchestra_type = "float64"
                },
                { name = "signal_float", orchestra_name = "some_bus/signal_float", orchestra_type = "float64", orchestra_index = 2 },
                { name = "signal_bool", orchestra_name = "some_bus/signal_bool", orchestra_type = "boolean" },
                { name = "signal_uint8", orchestra_name = "some_bus/some_nested_bus/signal_uint8", orchestra_type = "unsigned int8" },
                { name = "signal_uint8_2", orchestra_type = "unsigned int8" }
            )
        }

        out = {
            signals = (
                { name="pub_signal_float", init = 1.2, orchestra_name = "sub_signal_float", type = "float" }
            )
        }
    }
}

paths = (
    {
        in = "domain1"
        out = "domain1"
    }
)
```

## Running VILLASnode on a remote system

Orchestra offers the possibility to run VILLASnode (as an Orchestra client) on a separate machine from the real-time target.
This allows for integration and Co-simulation external systems.
In this case signals between the client and the framework are exchanged over a TCP or UDP/IP connection.

:::caution
This is an advanced use-case as it requires linking of VILLASnode against `libOpalOrchestra.so` on a non-OPAL-RTLinux system.

When [building VILLASnode with Nix](../../installation.md#nix), or using any of the by-Nix pre-compiled installations options like the [standalone](../../installation.md#standalone) or  `.rpm` packages or [Docker images](../../installation.md#docker),
VILLASnode, should be already compiled with the necessary `libOpalOrchestra.so` library and `OrchestraExtCommIP` helper tool.
:::

