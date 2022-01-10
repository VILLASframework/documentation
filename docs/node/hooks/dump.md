---
hide_table_of_contents: true
---

# Dump sample data

The `dump` hook will print a detailed dump of each processes samples to the standard output.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/dump.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/dump" />

## Example

@include node/etc/examples/hooks/dump.conf
