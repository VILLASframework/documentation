---
hide_table_of_contents: true
---

# Logging {#node-config-logging}

## Example {#node-config-logging-example}

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

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/logging" />
