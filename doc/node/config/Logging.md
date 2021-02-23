# Logging {#node-config-logging}

```
logging = {
	file = "/var/log/villas-node.log";
	level = 5;
	facilities = "socket,log,mem";	// log socket node-type, log and memory sub-system
}
```

## logging.level (string: "trace" | "debug" | "info" | "warning" | "error" | "critical" | "off") = "info" {#node-config-logging-level}

`log.level` expects one of the allowed strings to adjust the logging level.
Use this with care! Producing a lot of IO by enabling the debug output might decrease the performance of the server.
Omitting this setting or setting it to zero will disable debug messages completely.

## logging.file (string: path) {#node-config-logging-file}

Write all log messages to a file.

## logging.syslog (boolean) = false {#node-config-logging-syslog}

If enabled VILLASnode will log to the Syslog.

## logging.expressions (list of objects) {#node-config-logging-expressions}

The logging expression allow for a fine grained control of log levels per individual logger instance.
The logging expressions are provided as a list of logger name and level mappings:

```
logging = {
	expressions = (
		{
			name = "logger-name",
			level = "debug"
		}
	)
}
```
