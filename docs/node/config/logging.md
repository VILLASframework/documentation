# Logging

## Configuration

## logging.level (string: "trace" | "debug" | "info" | "warning" | "error" | "critical" | "off") = "info" {#level}

This setting expects one of the allowed strings to adjust the logging level.
Use this with care! Producing a lot of IO by enabling the debug output might decrease the performance of the server.
Omitting this setting or setting it to zero will disable debug messages completely.

## logging.file (string: path) {#file}

Write all log messages to a file.

## logging.syslog (boolean) = false {#syslog}

If enabled VILLASnode will log to the [system log](https://en.wikipedia.org/wiki/Syslog).

## logging.expressions (list of objects) = () {#expressions}

The logging expression allow for a fine grained control of log levels per individual logger instance.
Expressions are provided as a list of logger name pattern and the desired level.

**Note:** The expressions are evaluated in the order of their appearance in the list.

### logging.expressions[].name (string) {#expressions-name}

The [glob](https://man7.org/linux/man-pages/man7/glob.7.html)-style pattern to match the names of the loggers for which the level should be adjusted.

### logging.expressions[].level (string: "trace" | "debug" | "info" | "warning" | "error" | "critical" | "off") {#expressions-level}

The level which should be used for the matched loggers.

## Example {#example}

<!-- TODO: Convert to json -->
```
logging = {
	file = "/var/log/villas-node.log"
	level = "info" // global logging level
	expressions = (
		{
			// Enable debug logging for statistics hook
			name = "hook:*",
			level = "debug"
		}
	)
}
```
