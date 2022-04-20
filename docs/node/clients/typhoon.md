---
sidebar_label: Typhoon HIL Ethernet VE
title: Typhoon HIL Ethernet VE
---

# Typhoon HIL Ethernet VE <img align="right" width="150px" src="/img/logos/typhoon.png" alt="Typhoon HIL logo"></img>

VILLASnode can interface with Typhoon HIL simulators via their [_Ethernet Variable Exchange_ protocol](https://www.typhoon-hil.com/documentation/typhoon-hil-software-manual/References/ethernet_variable_exchange.html).
On VILLASnode's side this interconnection is realized with the [`socket` node-type](../nodes/socket.md) and the [`raw` format-type](../formats/raw.md).

## Tested Versions

The setup covered on this page has been tested with the following software versions:

- **Typhoon HIL Control Center:** 2022.1
- **VILLASnode:** [Commit 634d95362a7e776cc8d6b5999bc5c5e83be15870](https://git.rwth-aachen.de/acs/public/villas/node/-/commit/634d95362a7e776cc8d6b5999bc5c5e83be15870)

## Limitations

- Only the UDP protocol is supported by VILLASnode
- Sending and receiving of string values is not supported by VILLASnode
- All exchanged signals must use the same number of bytes
    - But data-types can be different for each signal

## Typhoon example model

VILLASnode ships with an example schematic for the Typhoon HIL control center.

- **Git:** <https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/clients/typhoon>

<figure align="center">
    <img alt="Typhoon model schematic" src="/img/screenshots/typhoon_ve_model.png" width="80%" />
    <figcaption>Typhoon model schematic.</figcaption>
</figure>

## Settings

In this demonstration we use the following settings as an example:

| Setting                           | Value           |
|:---                               |:---             |
| IP Address of Typhoon HIL target  | `192.168.2.100` |
| IP Address of VILLASnode          | `192.168.2.200` |
| Subnet Mask                       | `255.255.255.0` |
| UDP Port Number on both sides     | `12000`         |
| Number of bytes per signal        | `8` (64 bit)    |
| Endianess                         | Little          |

## Configuration

### VILLASnode

This [VILLASnode configuration](../config/index.md) configures a simple loopback of the data send by the Typhoon HIL target back to itself.

``` url="external/node/etc/examples/typhoon.conf" title="typhoon.conf"
stats = 1.0

nodes = {
    typhoon_1 = {
        type = "socket"
        layer = "udp"
        format = {
            type = "raw"
            endianess = "little"
            bits = 64
        }

        in = {
            address = "*:12000"

            hooks = (
                "stats"
            )

            signals = (
                { name = "signal0", type="float" },
                { name = "signal1", type="integer" },
                { name = "signal2", type="boolean" },
                { name = "signal3", type="float" },
                { name = "signal4", type="complex" }
            )
        }

        out = {
            address = "192.168.2.100:12000" # IP Address of Typhoon HIL target
        }
    }
}

paths = (
    {
        # A simple loopback
        in = "typhoon_1",
        out = "typhoon_1"
    }
)
```

#### ETH VE Setup properties

| Property name             | Value           |
|:---                       |:---             |
| IP address                | `192.168.2.100` |
| Subnet mask	            | `255.255.255.0` |

<figure align="center">
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_setup.png" width="50%" />
    <figcaption>ETH VE Setup properties.</figcaption>
</figure>

#### VE Send properties

Please use the following settings for the _VE Send_ blocks:

| Tab       | Property name             | Value              |
|:---       |:---                       |:---                |
| Network   | Protocol                  | UDP                |
| Network   | Specify local send port   | Unchecked          |
| Network   | Destination IP address    | `192.168.2.200`    |
| Network   | Destination port          | `12000`            |
| Data      | Configuration             | _See [signal configuration](#signal-configuration) section_ |

<figure align="center">
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_send_network.png" width="33%" />&nbsp;
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_send_data.png" width="33%" />
    <figcaption>ETH VE Send properties.</figcaption>
</figure>

#### VE Receive properties

| Tab       | Property name             | Value              |
|:---       |:---                       |:---                |
| Network   | Protocol                  | UDP                |
| Network   | Local receive port        | `12000`            |
| Network   | Specify source port       | Unchecked          |
| Network   | Specify source IP address | Unchecked          |
| Data      | Configuration             | _See [signal configuration](#signal-configuration) section_ |

<figure align="center">
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_receive_network.png" width="33%" />&nbsp;
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_receive_data.png" width="33%" />
    <figcaption>ETH VE Receive properties.</figcaption>
</figure>

### Signal configuration {#signal-configuration}

You can either configure the signal mapping via Typhoon graphical editor as shown in the screenshot below:

<figure align="center">
    <img alt="ETH VE Setup properties" src="/img/screenshots/typhoon_ve_signals.png" width="80%" />
    <figcaption>ETH VE Signal Configuration.</figcaption>
</figure>

Or alternatively you can copy the following signal configuration into the `Configuration` property:

```python title="Typhoon Signal Configuration"
[
    {'signal_name': 'signal0',      'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'real', 'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'},
    {'signal_name': 'signal1',      'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'int',  'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'},
    {'signal_name': 'signal2',      'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'uint', 'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'},
    {'signal_name': 'signal3',      'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'real', 'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'},
    {'signal_name': 'signal4_real', 'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'real', 'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'},
    {'signal_name': 'signal4_imag', 'signal_type': 'variable', 'signal_value': 'From input port', 'data_type': 'real', 'length': '8', 'endianess': 'little_endian', 'dimension': 'inherit'}]
```

#### Signal type mapping

| VILLAS signal type | Typhoon-HIL signal type  |
|:---                |:---                      |
| `boolean`          | `uint`                   |
| `float`            | `real`                   |
| `integer`          | `int`                    |
| `complex`          | use two consecutive `real` signals |
