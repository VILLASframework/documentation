# Configuration {#node-config}

The VILLASnode configuration consists of a a single file.

For a collection of example configuration files see: <https://git.rwth-aachen.de/acs/public/villas/node/tree/master/etc>.

# File format

VILLASnode currently supports two config file formats:

- [JSON](https://www.json.org/) (recommended)
- [libconfig](http://hyperrealm.github.io/libconfig/libconfig_manual.html#Configuration-Files)

# Structure

At the top level, the configuration file consists of these sections:

- @subpage node-config-global
- @subpage node-config-logging
- @subpage node-config-http
- @subpage node-config-nodes
- @subpage node-config-paths

# Examples

VILLASnode comes with a lot of existing configurations which can be used for inspiration:
https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/etc


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

# Tips & Tricks

## Use environment variables in your configuration

VILLASnode substitutes any environment variables in you JSON and libconfig configuration files.

To replace environment variables you must use the following syntax within any string value of your config: `${MYENV_VAR}`.

**Note:** Non-string values can currently not be subsituted by environment variables!

### Example

```
nodes = {
	file_node = {
		uri = "${FILE_PATH}
	}
}
```

## Include other files into your configuration

VILLASnode can include other files into you configuration.
This allows you to better structure and reuse parts of your configuration (e.g. the node definitions).

File inclusion is handled via a special key in JSON objects named `@include`.
The value of this key must point to an existing file on your file system.

**Note:** libconfig supports inclusion of other files [out of the box via @include directives](http://hyperrealm.github.io/libconfig/libconfig_manual.html#Include-Directives). So this tip is mostly useful for JSON configuration files.

### Example

#### params.json

```json
{
  "gain": 1.45,
  "t_dt": 50e-6
}
```

#### nodes.json

```json
{
  "test_node": {
    "type": "file",
    "in": {
      "signals": {
        "count": 12,
        "type": "float"
      }
    }
  },
  "signal_node": {
    "signal": "random",
    "in": {
      "hooks": [
        {
          "type": "lua",
          "script": "myscript.lua",
          "@include": "params.json"
        }
      ]
    }
  }
}
```

#### experiment1.conf

```json
{
  "nodes":{
    "@include": "nodes.json"
  },
  "paths": [
    {
      "in": "signal_node",
      "out": "test_node"
	}
  ]
}
```
