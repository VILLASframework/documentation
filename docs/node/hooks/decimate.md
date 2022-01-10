---
hide_table_of_contents: true
---

# Decimate sample rate

The `decimate` hook reduces the sampling rate by periodically discarding samples.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/decimate.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/decimate" />

## Example

@include node/etc/examples/hooks/decimate.conf
