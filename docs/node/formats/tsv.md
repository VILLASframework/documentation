---
hide_table_of_contents: true
---

# Tabulator-separated values

See also https://en.wikipedia.org/wiki/Tab-separated_values

## Implementation

The source code of the format-type is available here:
https://github.com/VILLASframework/node/blob/master/lib/formats/column.cpp

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/tsv" />

## Example Configuration {#example}

``` url="external/node/etc/examples/formats/tsv.conf" title="node/etc/examples/formats/tsv.conf"
nodes = {
	node = {
		type = "file"
		uri = "/dev/null"

		format = {
			type = "tsv"

			separator = "\t"
			delimiter = "\n"
			skip_first_line = false
			header = true
		}
	}
}
```

## Example Payload {#payload}

```tsv
secs	nsecs	sequence	random	sine	square	triangle	ramp
1623836070	376289994	0.100085770	0	0.02224543162071030	0.00005258397781155	-1.00000000000000000	0.99996652399999997	0.00000836900000000
1623836070	476470581	0.099907616	1	0.01533895833861668	0.58874533964681397	-1.00000000000000000	0.59924417600000002	0.10018895600000001
1623836070	576404132	0.099973339	2	0.02750008563829044	0.95129409546912413	-1.00000000000000000	0.19950997199999998	0.20012250700000001
1623836070	676432916	0.099945651	3	0.04032020994041897	0.95076233836683288	-1.00000000000000000	-0.20060516400000017	0.30015129100000004
1623836070	776433526	0.099939880	4	0.02607856387376608	0.58701284097251150	-1.00000000000000000	-0.60060760400000013	0.40015190100000003
```
