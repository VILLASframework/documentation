# IO Formats {#node-formats}

Some of the VILLASnode @ref node-types are transports which can exchange arbitrary payloads.
Examples for these node-types are: @ref node-type-mqtt, @ref node-type-amqp and @ref node-type-socket.

The format of the payload for these node-types is configurable.
New formats can be added via plugins.

Currently, the following formats are supported (or planned):

| Type             | Description                                      | Status  | Specification |
| :--              | :--                                              | :--     | |
| `villas.human`   | @ref node-format-villas-human                    | stable  | |
| `villas.binary`  | @ref node-format-villas-binary                   | stable  | |
| `json`           | Javascript Object Notation                       | stable  | http://json.org |
| `csv`            | Comma/Tabulator-separated values                 | stable  | |
| `raw`            | RAW/Binary data                                  | stable  | |
| `gtnet`          | RTDS GTNET-SKT                                   | stable  | |
| `gtnet.fake`     | RTDS GTNET-SKT (using the first three value as header) | stable  | |
| `protobuf`       | Googles Protobuf                                 | stable  | https://developers.google.com/protocol-buffers |
| `hdf5`           | Hierarchical Data Format                         | [planned](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/format-h5pt) | http://hdfgroup.org |
| `bson`           | Binary Javascript Object Notation                | [planned](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/format-bson) | http://bsonspec.org |
