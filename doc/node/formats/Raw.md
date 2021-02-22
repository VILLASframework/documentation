# Raw binary values {#node-format-raw}

VILLASnode supports sending samples formated as raw binary data.

Signal values are encoded according to their configured data-type in either integer or IEEE-754 floating point values.

## Supported variants

| Format-type  | Description                            | Width | Endianess | Floating-point Precission | Fake Header |
|:--           |:--                                     |:--    |:--        |:--                        |:--          |
| `raw.8`      | Raw  8 bit                             | 8     | -         | _not supported_           | no          |
| `raw.16.be`  | Raw 16 bit, big endian byte-order      | 16    | Big       | _not supported_           | no          |
| `raw.32.be`  | Raw 32 bit, big endian byte-order      | 32    | Big       | single                    | no          |
| `raw.64.be`  | Raw 64 bit, big endian byte-order      | 64    | Big       | double                    | no          |
| `raw.16.le`  | Raw 16 bit, little endian byte-order   | 16    | Little    | _not supported_           | no          |
| `raw.32.le`  | Raw 32 bit, little endian byte-order   | 32    | Little    | single                    | no          |
| `raw.64.le`  | Raw 64 bit, little endian byte-order   | 64    | Little    | double                    | no          |
| `raw.128.be` | Raw 128 bit, big endian byte-order     | 128   | Big       | long double               | no          |
| `raw.128.le` | Raw 128 bit, little endian byte-order  | 128   | Little    | long double               | no          |
| `gtnet`      | RTDS GTNET compatible                  | 32    | Big       | single                    | no          |
| `gtnet.fake` | RTDS GTNET compatible with fake header | 32    | Big       | single                    | yes         |

## Notes

- Floating-point encoding is only supported for width larger or equal to 32 bit.
- The `raw` format-type does not support vectors. Only a single sample can be encoded per packet/payload as there is no way to identify sample boundaries in the raw format.
- Complex sample values are supported and are encoded by real and imaginary parts with half of the precission as noted in the "Floating-point Precission" column above. E.g. in 64 bit mode real and imaginary components are encoded as two single-precission values encoded right after each other.
- Support for 128-bit wide values depends on you compiler support.

## Fake header mode

In the fake header mode VILLASnode uses the first three values in each en/decoded packet for the following purpose:

| Sample field     | Description                                                     | Data-type |
|:--               |:--                                                              |:--        |
| `sequence`       | Sequence number of the sample                                   | integer   |
| `ts.origin.sec`  | Timestamp (in seconds) of sampling instant at origin            | integer   |
| `ts.origin.nsec` | Timestamp (nano-seconds fraction) of sampling instant at origin | integer   |
