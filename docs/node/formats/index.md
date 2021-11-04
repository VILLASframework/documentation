---
sidebar_position: 1
sidebar_label: Overview
---

# Format-types

Some of the VILLASnode [node-types](../nodes/index.md) are transports which can exchange arbitrary payloads.
Examples for these node-types are: [MQTT](../nodes/mqtt.md), [AMQP](../nodes/amqp.md) and [Socket](../nodes/socket.md).

The format of the payload for these node-types is configurable.
New formats can be added via plugins.

Currently, the following formats are supported:

| Type                                 | Description                                      | Status |
| :--                                  | :--                                              | :--    |
| [`csv`](csv.md)                      | Comma-separated values                           | stable |
| [`iotagent-ul`](iotagent_ul.md)      | FIWARE IoTAgent Ultralight 2.0 Protocol          | stable |
| [`json.kakfa`](json_kakfa.md)        | Kafka Schema/Payload Javascript Object Notation  | stable |
| [`json`](json.md)                    | Javascript Object Notation                       | stable |
| [`protobuf`](protobuf.md)            | Google Protobuf                                  | stable |
| [`raw`](raw.md)                      | Raw binary values                                | stable |
| [`tsv`](tsv.md)                      | Tabulator-separated values                       | stable |
| [`value`](value.md)                  | Single value text                                | stable |
| [`villas.binary`](villas_binary.md)  | Custom VILLAS Binary                             | stable |
| [`villas.human`](villas_human.md)    | Custom VILLAS Human Readable                     | stable |

## Configuration {#node-config-format}

To use one of the format-types above, a setting named `format` must be present in the configuration of the respective node instance.
The value of the `format` setting can be eiter a simple string identifying one of the available format-types from the table above.
Alternatively, a JSON dictionary can be used to provide additional configuration settings to the payload format.
Please see below for examples of both approaches.

If the format-type is provided as an argument to a VILLASnode command-line tool (see [Usage](../usage/index.md)), also both variants are supported:

```bash
# Simple
villas signal -f json -v 5 sine

# Advanced
villas signal -f '{ "type": "json", "indent": 4, "precision": 4 }' -v 5 sine
```

Please note, that depending on you system configuration not all format-types might be available.
Use the following command to get a list of all available types on your system: `villas node -h`.

All format-types support the following generic options:

### real_precision (integer) = 17 {#config-precision}

Output all real numbers with at most n digits of precision. The valid range for this setting is between 0 and 31 (inclusive), and other values result in an undefined behavior.

By default, the precision is 17, to correctly and losslessly encode all IEEE 754 double precision floating point numbers.

### ts_origin (boolean) = true {#config-ts-origin}

If set, include the origin timestamp in the output.

### sequence (boolean) {#config-sequence}

If set, include the sequence number in the output.

### data (boolean) {#config-data}

If set, include the data in the output.

### offset (boolean) {#config-offset}

If set, include the offset between origin and received timestamp in the output.

## Example

### Simple {#example-simple}

<!-- TODO: Convert to json -->
```
nodes = {
    udp_json_node = {
        type = "socket"
        layer = "udp"

        format = "json"
        
        ...
    }
}
```

### Advanced {#example-advanced}

<!-- TODO: Convert to json -->
```
nodes = {
    udp_json_node = {
        type = "socket"
        layer = "udp"
        format = {
            "type": "json",

            "precision": 4,
            "indent": 4
        }
        
        ...
    }
}
```

## Abstract format-types {#abstract}

Thanks to C++ inheritance some format-types are well-suited as a base for other more specific format types:

- [JSON-based](json.md)
- [Line-based](line.md)
  - [Column-based](column.md)
