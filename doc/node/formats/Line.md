# Line-based formats {#node-format-line}

- @subpage node-format-villas-human
- @subpage node-format-column

# Configuration {#node-config-format-line}

## comment (string) = "#" {#node-config-format-line-comment}

A comment prefix character. Only single character delimiters are supported at the moment.

## header (boolean) = true {#node-config-format-line-header}

If set a header line will be written to the output before the forst line of data.

## delimiter (string) = "\n" {#node-config-format-line-delimiter}

The line delimiter. Only single character delimiters are supported at the moment.

## skip_first_line (boolean) = false {#node-config-format-line-skip-first-line}

Whether or not the first line of input should be discarded.
E.g. when its used for a header.

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/line.cpp
