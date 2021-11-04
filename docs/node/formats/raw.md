# Raw binary values

VILLASnode supports sending samples formated as raw binary data.

Signal values are encoded according to their configured data-type in either integer or IEEE-754 floating point values.

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/raw.cpp

## Configuration {#config}

The @ref node-format-raw format-type supports all [generic format options](@ref node-config-format) plus the following:

### bits (integer) = 32 {#config-bits}

The word size of each value in bits.

### endianess (string: "little" | "big") = "little" {#config-endianess}

The [endianess](https://en.wikipedia.org/wiki/Endianness) of multi-byte words.

The setting not be provided for `bits = 8`.

### fake (boolean) = false {#config-fake}

If enabled, the fake header mode VILLASnode uses the first three raw values in each en/decoded payload for the following purpose:

| Sample field     | Description                                                     | Data-type |
|:--               |:--                                                              |:--        |
| `sequence`       | Sequence number of the sample                                   | integer   |
| `ts.origin.sec`  | Timestamp (in seconds) of sampling instant at origin            | integer   |
| `ts.origin.nsec` | Timestamp (nano-seconds fraction) of sampling instant at origin | integer   |

## Example Configuration {#example}

@include node/etc/examples/formats/raw.conf

## Notes

- Floating-point encoding is only supported for width larger or equal to 32 bit.
- The `raw` format-type does not support vectors. Only a single sample can be encoded per payload as there is no way to identify sample boundaries in the raw format.
- Complex sample values are supported and are encoded by real and imaginary parts with half of the precission as noted in the "Floating-point Precission" column above. E.g. in 64 bit mode real and imaginary components are encoded as two single-precission values encoded right after each other.
- Support for 128-bit wide values depends on you compiler support.
