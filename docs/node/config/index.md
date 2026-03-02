---
sidebar_position: 1
sidebar_label: Overview
---

# Configuration

The VILLASnode configuration consists of a a single file.

For a collection of example configuration files see: https://github.com/VILLASframework/node/tree/master/etc/.

## File format

VILLASnode currently supports two config file formats:

- [JSON](https://www.json.org/) (recommended)
- [libconfig](http://hyperrealm.github.io/libconfig/libconfig_manual.html#Configuration-Files)

**Note:** Consider using the [`villas conf2json`](../usage/villas-conf2json.md) command to migrate your old configurations to JSON.

## Top-level Structure

At the top level, the configuration file consists of these sections:

- [`global`](./global.md)
- [`logging`](./logging.md)
- [`http`](./http.md)
- [`nodes`](./nodes.md)
- [`paths`](./paths.md)

## OpenAPI / JSON Schema Specification

There exists a formal description of the configuration file as a [JSON Schema](https://json-schema.org/) / [OpenAPI 3.0 specification](https://www.openapis.org/).

The remaining part of this subsection shows a HTML version of this schema rendered by [Redoc](https://github.com/Redocly/redoc):

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" pointer="#/components/schemas/config" />

## Example

VILLASnode comes with a lot of existing configurations which can be used for inspiration: https://github.com/VILLASframework/node/tree/master/etc/examples

<!-- convert to JSON -->
```
# Global configuration settings go here
stats = 2

# Webserver / API config
http = {
	port = 8081
}

# Logging
logging = {
	level = "debug
}

# Node definitions
nodes = {
	test_node = {
		in = {
			signals = {
				count = 12
				type = "float"
			}
		}
	}
}

# Path Mapping
paths = (
	{
		in = "test_node",
		out = "test_node"
	}
)
```
