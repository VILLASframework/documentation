# Javascript Object Notation {#node-format-json}

**Specification:** http://json.org

# Example

The structure of the JSON format is closely aligned with VILLASnode's internal data representation.
See @ref node-concept-sample for details.

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

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/json.cpp
