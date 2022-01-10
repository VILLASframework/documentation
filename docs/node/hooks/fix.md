---
hide_table_of_contents: true
---

# Fix missing metadata

The `fix` hook checks each sample and adds missing metadata such as timestamps or sequence numbers.

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/fix.cpp

## Configuration

The `fix` hook is a built-in hook. It is active by default and does not require any further options.

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/fix" />
