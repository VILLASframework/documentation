---
hide_table_of_contents: true
---

# Delta Sharing 

The `delta_sharing` node type integrates with a Delta Sharing server to read from Delta tables using Apache Arrow. 

## Prerequisites

- A reachable Delta Sharing server and a valid Delta Sharing profile path (`profile_path`).
- Apache Arrow and Parquet are required at build time. They are core dependencies for this node type. 
- A local cache directory to store the downloaded parquet files. 

Supported Keys: 

- `profile_path` (string, required): Path to a Delta Sharing profile file.
- `cache_dir` (string, optional): Local directory for caching fetched parquet files. 
- `table_path` (string, required for `read`/`write`): Table path in the format `server#share.schema.table`.
- `op` (string, optional): One of `read`, `write`, `noop`. Defaults to `noop`.
- `batch_size` (integer, optional): Batch size for chunk I/O (currently not implemented).

## Behaviour

- On start, the node initializes a Delta Sharing Client from `profile_path` and lists available shares, schemas and tables. 
- For `op = read`, the node parses `table_path` populates cache from each file, loads the first file as an Arrow table. It then maps Arrow types to VILLASnode supported datatypes.
- For `op = write` the node constructs and in-memory Arrow `Table` from outgoing VILLASnode samples based on the supported signal types. Current implementation does not upload to a Delta Sharing server yet.
- Supported datatypes for reading are DOUBLE, FLOAT, INT64, INT32. Others are classified as unsupported and filled with defaults.

## Example

``` url="external/node/etc/examples/nodes/delta_sharing.conf" title="node/etc/examples/nodes/delta_sharing.conf"

nodes = {
    delta_node = {
        type = "delta_sharing"


        ### The following settings are specific to the delta sharing node type!! ###

        profile_path = "dataset.share" # This specifies the URI where the server credentials are saved
        table_path = "dataset.share.share#delta_sharing.default.example_table" # The format for the table should be in this format: server#share.schema.table
        cache_dir = "cache" # This specifies the uri for the cache directory

        op = "read" # Either read or write tables
    }
}