---
hide_table_of_contents: true
---

# Logging

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/logging" />

## Example

<!-- TODO: Convert to json -->
```
logging = {
	file = "/var/log/villas-node.log"
	level = "info" // global logging level
	expressions = (
		{
			// Enable debug logging for statistics hook
			name = "hook:*",
			level = "debug"
		}
	)
}
```
