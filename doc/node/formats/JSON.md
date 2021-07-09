# Javascript Object Notation {#node-format-json}

**Specification:** http://json.org

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json.cpp

# Configuration {#node-config-format-json}

The @ref node-format-json format-type supports all [generic format options](@ref node-config-format) plus the following:

## indent (integer) = 0 {#node-config-format-json-indent}

Pretty-print the result, using newlines between array and object items, and indenting with n spaces. The valid range for n is between 0 and 31 (inclusive), other values result in an undefined output. If the settings is not used or is 0, no newlines are inserted between array and object items.

## compact (boolean) = false {#node-config-format-json-compact}

This flag enables a compact representation, i.e. sets the separator between array and object items to "," and between object keys and values to ":". Without this flag, the corresponding separators are ", " and ": " for more readable output.

## ensure_ascii (boolean) = false {#node-config-format-json-ensure-ascii}

If this flag is used, the output is guaranteed to consist only of ASCII characters. This is achieved by escaping all Unicode characters outside the ASCII range.

## sort_keys (boolean) = false {#node-config-format-json-sort-keys}

If this flag is used, all the objects in output are sorted by key. This is useful e.g. if two JSON texts are diffed or visually compared.

## escape_slash (boolean) = false {#node-config-format-json-escape-slash}

Escape the `/` characters in strings with `\/`.
# Example Configuration

```json
{
  "type": "json",
  "real_precision": 5,

  "indent": 2,
  "compact": false,
  "sort_keys": true,
  "escape_slash": false,
  "ensure_ascii": true,
}
```
# Example Payload

The structure of the JSON format is closely aligned with VILLASnode's internal data representation.

```json
{
  "ts": {
    "origin": [
      1556787289,
      492436800
    ]
  },
  "sequence": 55,
  "data": [
    0.022245,
    -1,
    true,
    {
        "real": 1.23,
        "imag": 4.56
    }
  ]
}
```
