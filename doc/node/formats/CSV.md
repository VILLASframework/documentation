# Comma-separated values {#node-format-csv}

See also https://en.wikipedia.org/wiki/Comma-separated_values

# Configuration

The @ref node-format-csv format-type supports the options documented on the following pages:
- [generic format options](@ref node-config-format)
- [line format options](@ref node-config-format-line)
- [column format options](@ref node-config-format-column)

# Example Configuration

```json
{
  "type": "csv",

  "separator": ",",
  "delimiter": "\n",
}
```

# Example Payload

```
secs,nsecs,sequence,random,sine,square,triangle,ramp
1623835888,497848153,0.100084805,0,0.02224543162071030,0.00005157238497847,-1.00000000000000000,0.99996716799999996,0.00000820800000000
```

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/column.cpp
