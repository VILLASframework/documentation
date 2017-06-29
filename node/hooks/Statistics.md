# Statistic collection {#node-hook-stats_collect}

@todo Complete documentation

```
paths (
	{
		...
		hooks = (
			{
				type = "stats"
				
				warmup = 1000,
				buckets = 100,
				verbose = true,
				format = "json",
				output = "/villas/results/statistics_of_path.json"
			},
			{
				type = "stats_send",
				
				destination = "some_node",
				mode = "periodic",
				decimation = 10
			}
		)
	}
)
```