---
hide_table_of_contents: true
---

# Cast signal values

The `cast` hook casts the data-type of signals and can set a new name and unit to the casted signal.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/cast.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/cast" />

## Example

@include node/etc/examples/hooks/cast.conf
