---
hide_table_of_contents: true
---

# Handle restarts

The `restart` hook tries to detect starts/restarts of simulation cases by looking for wrap-around in sequence numbers.

## Implementation

The source code of the hook is available here:
https://github.com/VILLASframework/node/blob/master/lib/hooks/restart.cpp

## Configuration

The `restart` hook is a built-in hook. It is active by default and does not require any further options.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/restart" />
