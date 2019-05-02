# IO Formats {#node-formats}

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
| `raw`            | RAW/Binary data                                  | stable |
| `gtnet`          | RTDS GTNET-SKT                                   | stable |
| `gtnet.fake`     | RTDS GTNET-SKT (using the first three value as header) | stable |
| `protobuf`       | @subpage node-format-protobuf                    | stable |
| `hdf5`           | @subpage node-format-hdf                         | [planned](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/format-h5pt) |
| `bson`           | @subpage node-format-bson                        | [planned](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/format-bson) |
