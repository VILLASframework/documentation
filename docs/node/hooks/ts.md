---
hide_table_of_contents: true
---

# Timestamp

The `ts` hook overwrite the origin timestamp field of each sample with the current system time.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/ts.cpp

## Configuration

The `ts` hook has no configurable options.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/ts" />

## Example

@include node/etc/examples/hooks/ts.conf
