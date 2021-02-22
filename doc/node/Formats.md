# Format-types {#node-formats}

Some of the VILLASnode @ref node-types are transports which can exchange arbitrary payloads.
Examples for these node-types are: @ref node-type-mqtt, @ref node-type-amqp and @ref node-type-socket.

The format of the payload for these node-types is configurable.
New formats can be added via plugins.

Currently, the following formats are supported (or planned):

| Type             | Description                                      | Status |
| :--              | :--                                              | :--    |
| `villas.human`   | @subpage node-format-villas-human                | stable |
| `villas.binary`  | @subpage node-format-villas-binary               | stable |
| `json`           | @subpage node-format-json                        | stable |
| `csv`            | Comma/Tabulator-separated values                 | stable |
| `raw`            | @subpage node-format-raw                         | stable |
| `gtnet`          | @subpage node-format-raw                         | stable |
| `gtnet.fake`     | @subpage node-format-raw                         | stable |
| `protobuf`       | @subpage node-format-protobuf                    | stable |
| `hdf5`           | @subpage node-format-hdf                         | [planned](https://git.rwth-aachen.de/acs/public/villas/node/tree/format-h5pt) |
| `iotagent-ul`    | @subpage node-format-fiware-iotagent-ul          | stable |
| `value`          | @subpage node-format-fiware-iotagent-ul          | stable |

## Configuration

To use one of the format-types above, a setting named `format` must be present in the configuration of the respective node instance.
The value of the `format` setting must match one of the values from the type column of the table above.

Please note, that depending on you system configuration not all format-types might be available.
Use the following command to get a list of all available types on your system: `villas node -h`.

#### Example

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
