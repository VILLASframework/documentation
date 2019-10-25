# Development {#node-dev}

Developement is currently coordinated by Steffen Vogel <stvogel@eonerc.rwth-aachen.de> using [GitLab](http://git.rwth-aachen.de/acs/public/villas/VILLASnode).
Please feel free to submit pull requests or bug reports.

A [contribution guide](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/CONTRIBUTING.md) is available in the [Git repository](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/).

- @subpage node-dev-api-node
- @subpage node-dev-api-relay
- @subpage node-dev-advio

## Programming Paradigm

VILLASnode is currently written in C using the ISO C11 standard while following an object oriented programming paradigm.

Main _classes_ in VILLASnode are `struct sample`, `struct node`, `struct path` and `struct hook`.
In order to track the life cycle of those objects, each of them has an `enum state` member.
The following figure illustrates the state machine which is used:

@image html uml/NodeStatechartDiagram.svg Common states of objects in VILLASnode width=60%

## Shared library: libvillas

VILLASnode is split into a shared library called libvillas and a couple of executables (`villas-node`, `villas-pipe`, `villas-test`, `villas-signal`, ...) which are linked against this library.

## Plugins {#node-plugins}

There are many places where VILLASnode can easily extended with plugins.
All node-types, hook functions or new IO formats are implemented via plugins.

A plugin is usually implemented in a single C file containing only static functions and variables.
All entrypoints of a plugin a provided via a `struct plugin` which is registered with the `REGISTER_PLUGIN()` macro.

The `REGISTER_PLUGIN()` macro adds two hidden functions for loading and unloading the plugin which are automatically called by the system library loader.

### Example of new node type

See `include/villas/plugin.h`

See `lib/nodes/file.c`:

```
[...]

static struct plugin p = {
	.name		= "file",
	.description	= "support for file log / replay node type",
	.type		= PLUGIN_TYPE_NODE,
	.node		= {
		.vectorize	= 1,
		.size		= sizeof(struct file),
		.reverse	= file_reverse,
		.parse		= file_parse,
		.print		= file_print,
		.start		= file_start,
		.stop		= file_stop,
		.read		= file_read,
		.write		= file_write,
		.instances	= LIST_INIT()
	}
};

REGISTER_PLUGIN(&p)
```
