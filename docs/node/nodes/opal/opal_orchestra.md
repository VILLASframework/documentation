---
hide_table_of_contents: true
---

# OPAL-RT Orchestra

Orchstra is OPAL-RT's co-simulation framework for integrating custom code and external models.
More information about Orchestra can be found in the [OPAL-RT Wiki](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/143626248/Orchestra).

## Prerequisites

- `libOpalOrchestra.so` & `RTAPI.h`

## Implementation

:::note
The implementation of the `opal.orchestra` node-type is currently not open source.

Please contact [Steffen Vogel](mailto:steffen.vogel@opal-rt.com) if you are interested in run
:::

## Installation


## Configuration {#config}

### Reference

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/opal_orchestra" />

## Example

``` url="external/node/etc/examples/nodes/opal_orchestra.conf" title="node/etc/examples/nodes/opal_orchestra.conf"
nodes = {
	opal_orchestra_node = {
		type	= "opal.orchestra"

        ddf = "orchestra.xml"
        domain = "orchestra_domain_1"
	}
}
```
