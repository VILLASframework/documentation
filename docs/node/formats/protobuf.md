---
hide_table_of_contents: true
---

# Google Protobuf

**Specification:** https://developers.google.com/protocol-buffers

## Protocol Definition

The `.proto` Protocol Buffers Version Language Specification of the payload used by VILLASnode is available in the Git repository:

https://github.com/VILLASframework/node/blob/master/lib/formats/villas.proto

```protobuf url="external/node/lib/formats/villas.proto" title="node/lib/formats/villas.proto"
/// Protobuf schema based on msg_format.h
///
/// @file
/// @author Steffen Vogel <svogel2@eonerc.rwth-aachen.de>
/// @copyright 2014-2022, Institute for Automation of Complex Power Systems, EONERC
/// @license Apache 2.0
////////////////////////////////////////////////////////////////////////////////////

syntax = "proto2";

package villas.node;

message Message {
	repeated Sample samples = 1;
}

message Sample {
	enum Type {
		DATA = 1;				// Message contains float / integer data values
		START = 2;				// Message marks the beginning of a new simulation case
		STOP = 3;				// Message marks the end of a simulation case
	};

	required Type type = 1 [default = DATA];
	optional uint64 sequence = 2;			// The sequence number is incremented by one for consecutive messages.
	optional Timestamp timestamp = 4;
	repeated Value values = 5;
}

message Timestamp {
	required uint32 sec = 1;			// Seconds since 1970-01-01 00:00:00
	required uint32 nsec = 2;			// Nanoseconds of the current second.
}

message Value {
	oneof value {
		double f = 1;				// Floating point values.
		int64 i = 2;				// Integer values.
		bool b = 3;				// Boolean values.
		Complex z = 4;				// Complex values.
	}
}

message Complex {
	required float real = 1;			// Real component
	required float imag = 2;			// Imaginary component
}
```

## Implementation

The source code of the format-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/formats/protobuf.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/protobuf" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/protobuf.conf" title="node/etc/examples/formats/protobuf.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = "protobuf"
	}
}
```
