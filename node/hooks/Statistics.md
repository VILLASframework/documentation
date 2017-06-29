# Statistic collection {#node-hook-stats_collect}

@todo Complete documentation

# Collection

## format (string: "json" | "matlab" | "human") {#node-config-hook-stats-format}

## buckets (integer) {#node-config-hook-stats-buckets}

## warmup (integer) {#node-config-hook-stats-warmup}

## verbose (boolean) {#node-config-hook-stats-verbose}

## output (string: uri) {#node-config-hook-stats-output}

# Sending

## destination (string: node name) {#node-config-hook-stats_send-destination}

## decimation (integer) {#node-config-hook-stats_send-decimation}

## mode (string: "periodic" | "read") {#node-config-hook-stats_send-mode}

# Example

```
paths (
	{
		...
		hooks = (
			{
				type = "stats"
				
				warmup = 1000,				# Skip the first 1000 samples for statistics
				buckets = 100,				# Create histograms with 100 buckets
				verbose = true,				# Generate more verbose statistic reports
				format = "json",			# The format for the statistic report
				
				# The file where you want to write the report to.
				# If omitted, stdout (the terminal) will be used.
				output = "/villas/results/statistics_of_path.json"
			},
			{
				type = "stats_send",

				destination = "some_node",	# The name of the node to which the statistics should be send
				mode = "periodic",
				decimation = 10
			}
		)
	}
)
```