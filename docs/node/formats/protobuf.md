---
hide_table_of_contents: true
---

# Google Protobuf

**Specification:** https://developers.google.com/protocol-buffers

## Protocol Definition

The `.proto` Protocol Buffers Version Language Specification of the payload used by VILLASnode is available in the Git repository:

https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/formats/villas.proto

@include node/lib/formats/villas.proto

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/protobuf.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/protobuf" />

## Example Configuration {#example}

@include node/etc/examples/formats/protobuf.conf
