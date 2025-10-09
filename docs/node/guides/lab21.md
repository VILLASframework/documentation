---
sidebar_position: 20
---

# Lab 21: Delta Sharing

This lab contains an example configuration on VILLASnode's delta_sharing node-type.

An example is created to connect to an open source server present at "https://sharing.delta.io/delta_sharing/". 

The delta sharing node connects to the server mentioned in the share file added in the configuration. 
The required table is then read by mentioning the schema and the name of the table. 

## VILLASnode configuration file

### Delta Sharing client

``` url="external/node/etc/labs/lab21.conf" title="node/etc/labs/lab21.conf"
nodes = {
    node1 = {
        type = "delta_sharing"
        profile_path = "open-datasets.share"
        table_path = "open-datasets.share#delta_sharing.default.COVID_19_NYT"
        cache_dir = "cache"
        op = "read"
    },
    node2 = {
        type = "file"
        uri = "delta_output.dat"
        in = {
            epoch_mode = "direct"
            read_mode = "all"
            eof = "stop"
        }
        out = {

        }
    }

}
paths = (
    {
        in = "node1"
        out = "node2"
    }
)
```

### Share file

``` url="external/node/etc/labs/open-datasets.share" title="node/etc/labs/open-datasets.share"
{
  "shareCredentialsVersion": 1,
  "endpoint": "https://sharing.delta.io/delta-sharing/",
  "bearerToken": "faaie590d541265bcab1f2de9813274bf233"
}
```

This configuration file is used to read from and (planned) write to Delta Sharing tables using Apache Arrow/Parquet. Files downloaded from the server are cached locally.

Default cache directory is cwd/cache unless specified otherwise using the cache_dir parameter.

Supported keys in the configuration: 
profile_path: path to a Delta Sharing profile JSON. 
table_path: path for the table, here we mention the server, share and the schema in the format - ```server#share.schame.table```
batch_size: batch size to be used for parsing rows in the Arrow table. Currently not implemented.

The output is then piped into a .dat file using the file nodetype. 

To start the delta sharing node, in a terminal: 

```shell 
villas node lab21.conf
```

The received data from the remote table should then be displayed in the terminal and also written into the dat file. 

