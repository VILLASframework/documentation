# Protocol {#controller-protocol}

This page documents the data model/protocol used by VILLAScontroller to control and monitor simulators.
The protocol uses AMQP to transport JSON encoded objects which are specified in the following document.

VILLAScontroller is implemented in Python and using the [Kombo messaging package](https://kombu.readthedocs.io).

The Git repository is available at: http://git.rwth-aachen.de/acs/public/villas/VILLAScontroller

## Entities {#controller-protocol-entities}

The puporse of VILLAScontroller is the managemeng and control of simulators and other related entities.

For the purpose of routing and grouping the entities, we introduce the following categories:

- `simulator`
- `simulation`
- `interface`
- `gateway`
- `model`

## Exchange {#controller-protocol-amqp-exchange}

Almost all messages processed by VILLAScontroller are sent via an AMQP `headers` exchange.

The exchange is named `villas`.

## Routing {#controller-protocol-amqp-routing}

The following headers are used to identify and route messages to the receipients:

- `realm` describes the entity which is responsible for operating the equipment.
  The realm should be a fully quallified domain name (FQDN) in reverse order.
  - Examples:
    - `de.rwth-aachen.eonerc.acs`
    - `gov.inl`

- `category` describes the classes of equipment.
  - Examples:
    - `simulator`
    - `gateway` (_planned_)
    - `interface` (_planned_)
    - `model` (_planned_)

- `type` further defines the type/vendor of a device within its class.
  - Examples:
    - `dummy`
    - `dpsim`
    - `rtlab` (_planned_)
    - `rscad` (_planned_)

- `uuid` is a globally unique identifier
  - Examples:
    - `56babc1e-0476-11e8-9375-471525328a77`

Example of a message header:

```json
{
	"realm" : "de.rwth-aachen.eonerc.acs",
	"category" : "simulator",
	"type" : "rtlab",
	"uuid" : "56babc1e-0476-11e8-9375-471525328a77"
}
```

## Discovery

As a messaging protocol, AMQP brokers do not store message contents.
Messages always are forwarded, queued or dropped.

Therefore, the broker cannot record the state or presence of entitities.

This section describes a simple discovery mechanism to work around this limitation.
Each entity must react on `action = ping` messages and respond immediatly with a status response message.

### Ping Request

```json
{
	"action" : "ping"
}
```

### Status Response

```json
{
	"status" : {
		"realm" : "de.rwth-aachen.eonerc.acs",
		"category" : "simulator",
		"type" : "dpsim",
		"uuid" : "73b81a0c-fef2-11e7-a149-320084a2b301",

		// The remainder of this status message is specific to the category of the entity
	},
	"when" : 12312312412124
}
```

The `when` attribute contains a UNIX timestamp describing the moment of the last update.
It can be used to expire outdated status messages.

In addition to the message payload above, each message is sent with the `realm`, `category`, `type` and `uuid` header fields which identify the originating entity.

## Simulators {#controller-protocol-category-simulator}

## State Machine

@image html uml/SimulatorStateDiagram.svg

### Status Response


```json
{
	"status" : {
		"version" : "0.1.0",
		"kernel" : "2.6.18-274.7.1.el5PAE",
		"state" : "idle",
		"name" : "OP5600",
		"description" : "some optional description",
		"location" : "OPAL-RT Rack, ACS Real-time Lab, EONERC, RWTH",
		"owner" : "stvogel@eonerc.rwth-aachen.de",
		"uptime" : 123124,
		"models" : [
			"uuid-1",
			"uuid-2",
			"uuid-N"
		]
	},
	"when" : 1234567890.123
}
```

### Reset Simulator

```json
{
	"action" : "simulator.reset",
	"when" : 1234567890.123
}
```

### Shutdown Simulator

**Note:** Currently these actions are belonging to the `simulator` category. Lateron, the should be moved to the `simulation` category.

```json
{
	"request" : "simulator.shutdown",
	"when" : 1234567890.123
}
```

### Start Simulation

Start the simulation at a specific point in time.

```json
{
	"action" : "simulator.start",
	"when" : 1234567890.123
}
```

### Stop Simulation

Stop the simulation at a specific point in time.

```json
{
	"action" : "simulator.stop",
	"when" : 1234567890.123
}
```

### Pause Simulation

Pause the simulation at a specific point in time.

```json
{
	"action" : "simulator.pause",
	"when" : 1234567890.123
}
```

### Resume Simulation

Resume the simulation at a specific point in time.

```json
{
	"action" : "simulator.resume",
	"when" : 1234567890.123
}
```

### Load Model

Load a Zip archive containing the model onto the simulation workstation.

```json
{
	"action" : "stimulator.load",
	"uuid" : "a-unique-uuid-to-identify-the-model"
	"name" : "A name of the model shown in the log files / interfaces",
	"description" : "A more detailed description of the model"
	"url" : "http://web.villas.fein-aachen.org/models/DFADF953-8F38-4862-959C-ACF2662D9B7A.zip"
}
```

After a successfull download and extraction of the archive, the new simulator will send a status update message listing the new model UUID.

## Models

**Note:** The remaining part of this document is a draft and not ready yet for implementation.

### Status Response

```json
{
	"status" : {
		"url" : "http://web.villas.fein-aachen.org/models/DFADF953-8F38-4862-959C-ACF2662D9B7A.zip",
		"name" : "A name of the model shown in the log files / interfaces",
		"description" : "A more detailed description of the model",
		"simulations" : [
			"uuid-1",
			"uuid-2",
			"uuid-N"
		]
	},
	"when" : 1234567890.123
}
```

### Compile Model

```json
{
	"action" : "model.compile"
}
```

### Clean Model

Destroy and delete all model data on the simulation node.

```json
{
	"action" : "model.clean",
}
```

## Simulation

A simulation is an execution of a model on a simulator.

### Status Response

```json
{
	"status" : {
		"state" : "finished",
		"results" : [
			"C:\VILLAScontroller\simulations\uuid\results.csv"
		]
	}
}
```

### Upload Results

Upload results to a remote server

```json
{
	"action" : "simulation.upload",
	"url" : "http://web.villas.fein-aachen.org/results/DFADF953-8F38-4862-959C-ACF2662D9B7A.zip"
}
```

### Delete

```json
{
	"action" : "simulation.delete"
}
```
