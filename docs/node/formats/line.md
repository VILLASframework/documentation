# Line-based formats

There are currently the following line-based payload format-types:

- [VILLASnode human readable](villas_human.md)
- [Column-based](column.md)

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/line.cpp

## Configuration {#config}

### comment (string) = "#" {#config-comment}

A comment prefix character. Only single character delimiters are supported at the moment.

### header (boolean) = true {#config-header}

If set a header line will be written to the output before the forst line of data.

### delimiter (string) = "\n" {#config-delimiter}

The line delimiter. Only single character delimiters are supported at the moment.

### skip_first_line (boolean) = false {#config-skip-first-line}

Whether or not the first line of input should be discarded.
E.g. when its used for a header.
