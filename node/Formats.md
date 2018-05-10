# IO Formats {#node-formats}

Some of the VILLASnode @ref node-types are transports which can exchange arbitrary payloads.
Examples for these node-types are: @ref node-type-mqtt, @ref node-type-amqp and @ref node-type-socket.

The format of the payload for these node-types is configurable.
New formats can be added via plugins.

Currently, the following formats are supported (or planned):

| Type             | Description                                      | Status  | Specification |
| :--              | :--                                              | :--     | |
| `json`           | Javascript Object Notation                       | stable  | http://json.org |
| `csv`            | Comma/Tabulator-separated values                 | stable  | |
| `raw`            | RAW/Binary data                                  | stable  | |
| `villas-human`   | Custom human-readable format for VILLASframework | stable  | |
| `villas-binary`  | Custom binary format for VILLASframework         | stable  | |
| `protobuf`       | Googles Protobuf                                 | stable  | https://developers.google.com/protocol-buffers |
| `hdf5`           | Hierarchical Data Format                         | planned | http://hdfgroup.org |
| `bson`           | Binary Javascript Object Notation                | planned | http://bsonspec.org |

## Custom VILLAS formats

### Human Readable

### Binary packet format
