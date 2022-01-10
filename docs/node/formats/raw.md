---
hide_table_of_contents: true
---

# Raw binary values

VILLASnode supports sending samples formated as raw binary data.

Signal values are encoded according to their configured data-type in either integer or IEEE-754 floating point values.

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/raw.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/raw" />

## Example Configuration {#example}

@include node/etc/examples/formats/raw.conf

## Notes

- Floating-point encoding is only supported for width larger or equal to 32 bit.
- The `raw` format-type does not support vectors. Only a single sample can be encoded per payload as there is no way to identify sample boundaries in the raw format.
- Complex sample values are supported and are encoded by real and imaginary parts with half of the precission as noted in the "Floating-point Precission" column above. E.g. in 64 bit mode real and imaginary components are encoded as two single-precission values encoded right after each other.
- Support for 128-bit wide values depends on you compiler support.
