# Signal {#node-type-signal}

The @ref node-type-signal node-type is a simple signal generator which can be used to generate sine, square, ramp, triangle or random signals at user definable frequencies, rates, amplitudes.

Most commonly it is used for testing when no real simulation data is available.

**Note:** There is also the `villas-signal` tool which has a similar purpose.

# Configuration {#node-config-signal}

## signal (string: "sine" | "ramp" | "triangle" | "random" | "mixed") {#node-config-file-signal}

The type of signal which should be generated.

If the type is `mixed` and more than one value is generated (see @ref node-config-signal-values), values of a sample contain all available signal types.

If the type is not `mixed` and more than one value is generated (see @ref node-config-signal-values), all values are of a sample are equal.

If the type is `random`, a random walk with normal distributed step sizes will be generated.

If the type is `ramp`, the generator will produce a ramp signal in the interval `[ 0, 1 / f ]`.

## values (integer) {#node-config-signal-values}

The number of sample which each emitted sample should contain.

## rate (integer) {#node-config-signal-rate}

The rate at which sample should be emitted by the node.

## amplitude (float) {#node-config-signal-amplitude}

The amplitude of the signal when @ref node-config-signal is one of `sine`, `square` or `triangle`.

## frequency (float) {#node-config-signal-frequency}

The frequency of the signal when @ref node-config-signal is one of `sine`, `square`, `triangle` or `ramp`.

## stddev (float) {#node-config-signal-stddev}

The standard deviation of the normal distributed steps if @ref node-config-signal is `random`.

## Example

```
nodes = {
	signal_node = {
		type = "signal",

		signal = "sine",			# One of "sine", "square", "ramp", "triangle", "random", "mixed"
		values = 4,				# Number of values per sample
		amplitude = 2.3,			# Amplitude of generated signals
		frequency = 10,				# Frequency of generated signals
		stddev = 2,				# Standard deviation of random signals (normal distributed)
		rate = 10.0,				# Sample rate
	},
}
```
