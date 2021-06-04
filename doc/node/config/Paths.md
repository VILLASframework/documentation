# Paths {#node-config-paths}

The path section consists of a **list** of paths:

```
paths = (
	{
		in = [
			"rtds.data[0-5]",
			"web.data[0-2]"
		],
		out = [
			"broker",
			"opal"
		],

		reverse = false,
		mode = "any",
		mask = [ "rtds" ],
		rate = 100,
		original_sequence_no = false,

		hooks = (
			{
				type = "print"
			},
			{
				type = "ts"
			}
		)
	}
)
```

Every path can have the following settings:

## in (list of strings: node-names | mapping expression) {#node-config-path-in}

The `in` settings expects the name of one or more source nodes or mapping expressions.

## out (list of strings: node-names) {#node-config-path-out}

The `out` setting expects the name of one or more destination nodes.
Each sample which is processed by the path will be sent to each of the destination nodes.

## enabled (boolean) {#node-config-path-enabled}

The optional `enabled` setting can be used to temporarily disable a path.
If omitted, the path is enabled by default.

## reverse (boolean) {#node-config-path-reverse}

By default, the path is unidirectional. Meaning, that it only forwards samples from the source to the destination.
Sometimes a bidirectional path is needed.
This can be accomplished by setting `reverse` to `true`.

## mode (string: "all" | "any") = "any" {#node-config-path-mode}

The mode setting specifies under which condition a path is _triggered_.
A triggered path will multiplex / merge samples from its input nodes and run the configured hook functions on them.
Afterwards the processed and merged samples will be send to all output nodes.

Two modes are currently supported:

- `any`: The path will trigger the path as soon as any of the masked (see @ref node-config-path-mask) input nodes received new samples.
- `all`: The path will trigger the path as soon as all input nodes received at least one new sample.

## mask (list of strings: node-names) = all nodes {#node-config-path-mask}

This setting allows masking the the input nodes which can trigger the path.

See also: @ref node-config-path-mode

## rate (float) = 0 {#node-config-path-rate}

A non-zero value will periodically trigger the path and resend the last sample again.

A value of zero will disable this feature.

## original_sequence_no (boolean) = false {#node-config-path-original_sequence_no}
When this flag is set, the original sequence number from the source node will be used when multiplexing the nodes.

## hooks (list of objects: hooks) {#node-config-path-hooks}

A list of hook functions which will be executed for each sample which is processed by this path.

Please consult the @ref node-concept-hook chapter of this documentation for details.

### hooks[].type (string: "print" | "drop" | ...) {#node-config-hooks-type}

### hooks[].enabled (boolean) = true {#node-config-hooks-enabled}
