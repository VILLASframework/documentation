---
hide_table_of_contents: true
---

# FIWARE IoTAgent Ultralight 2.0 Protocol

Ultralight 2.0 is a lightweight text based protocol aimed to constrained devices and communications where the bandwidth and device memory may be limited resources.

It is used by FIWAREs IotAgent-UL. 

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/iotagent_ul.cpp

## Configuration {#config}

The `iotagent_ul` format-type supports the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/iotagent_ul" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/iotagent_ul.conf" title="node/etc/examples/formats/iotagent_ul.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = "iotagent_ul"
	}
}
```

## Further Documentation

- https://fiware-iotagent-ul.readthedocs.io/
