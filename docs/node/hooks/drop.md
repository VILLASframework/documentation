---
hide_table_of_contents: true
---

# Drop reordered samples

The `drop` hook will discard samples which a received with repeating or reordered sequence numbers.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/drop.cpp

## Configuration

The `drop` hook is a built-in hook. It is active by default and does not require any further options.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/dump" />
