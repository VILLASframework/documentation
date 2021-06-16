# Comma-separated values {#node-format-csv}

See also https://en.wikipedia.org/wiki/Comma-separated_values

# Configuration

The @ref node-format-csv format-type supports all [generic format options](@ref node-config-format) plus the following:

## separator (string) = "," {#node-config-format-column-separator}

The column separator. Only single character separators are supported at the moment.

## header (boolean) = true {#node-config-format-line-header}

If set a header will be printed before the forst line of data.

## delimiter (string) = "\n" {#node-config-format-line-delimiter}

The line delimiter. Only single character delimiters are supported at the moment.

# Example configuration

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
