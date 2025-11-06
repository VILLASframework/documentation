---
hide_table_of_contents: true
---

# Raw binary values

VILLASnode supports sending samples formatted as raw binary data.

Signal values are encoded according to their configured data-type in either integer or IEEE-754 floating point values.

## Implementation

The source code of the format-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/formats/raw.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/raw" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/raw.conf" title="node/etc/examples/formats/raw.conf"
nodes = {
    node = {
        type = "file"
        uri = "/dev/null"

        format = {
            type = "raw"

            bits = 32
            endianess = "little"
            fake = false
        }
    }
}
```

## Notes

- Floating-point encoding is only supported for width larger or equal to 32 bit.
- The `raw` format-type does not support vectors. Only a single sample can be encoded per payload as there is no way to identify sample boundaries in the raw format.
- Complex sample values are supported and are encoded by real and imaginary parts with half of the precision as noted in the "Floating-point Precision" column above. E.g. in 64 bit mode real and imaginary components are encoded as two single-precision values encoded right after each other.
- Support for 128-bit wide values depends on you compiler support.
