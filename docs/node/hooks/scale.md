---
hide_table_of_contents: true
---

# Scale and offset signals

The `scale` hook modifies sample signals by a gain factor and optionally ads an offset.
First the original signal value is multiplied by the gain, then the offset is added.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/scale.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/scale" />

## Example

@include node/etc/examples/hooks/scale.conf
