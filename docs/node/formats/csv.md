# Comma-separated values

See also https://en.wikipedia.org/wiki/Comma-separated_values

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/column.cpp

## Configuration {#config}

The @ref node-format-csv format-type supports the options documented on the following pages:
- [generic format options](@ref node-config-format)
- [line format options](@ref node-config-format-line)
- [column format options](@ref node-config-format-column)

## Example Configuration {#example}

@include node/etc/examples/formats/csv.conf

## Example Payload {#payload}

```csv
secs,nsecs,sequence,random,sine,square,triangle,ramp
1623835888,497848153,0.100084805,0,0.02224543162071030,0.00005157238497847,-1.00000000000000000,0.99996716799999996,0.00000820800000000
```
