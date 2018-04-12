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

In a messaging protocol like AMQP, brokers do not store message contents in a persistant way.
They only temporarily queue messages until they have been delivered.
Therefore, the broker cannot keep track of the state or presence of entitities.

This section describes a simple discovery mechanism to work around this limitation.
Each entity must react on `action = ping` messages and respond immediatly with a status response message.

```json
{
	"action" : "ping"
}
```

After receiving such a message, each entity shall send a status update message as decribed below.

## Simulators {#controller-protocol-category-simulator}

## State Machine

### Status Update

```json
{
	"status" : {
		"version" : "0.1.0",
		"kernel" : "2.6.18-274.7.1.el5PAE",
		"state" : "idle",
		"simulation" : "id-of-the-current-simulation",
		"name" : "OP5600",
		"description" : "some optional description",
		"location" : "OPAL-RT Rack, ACS Real-time Lab, EONERC, RWTH",
		"owner" : "stvogel@eonerc.rwth-aachen.de",
		"uptime" : 123124
	},
	"when" : 1234567890.123
}
```

### Reset Simulator

```json
{
	"action" : "reset",
	"when" : 1234567890.123
}
```

### Shutdown Simulator

```json
{
	"action" : "shutdown",
	"when" : 1234567890.123
}
```

### Start Simulation

Start the simulation at a specific point in time.

```json
{
	"action" : "start",
	"parameters" : {
	    "model" : {
	        /* Where to get the model from */
	        "url" : "https://web.villas.fein-aachen.org/files/asfskdjfhslkdfsd.zip",
	        "type" : "some-mime-type-here"
	    },
	    "results" : {
	        /* Where to upload the results to */
	        "url" : "file://opt/results/{{uuid}}.txt",
	        "type" : "some-mime-type-here"
	    }
	    "timestep" : 50e-6,
	    "duration" : 10,
	    "domain" : "dp",
	    "downsample" : 1
	}
	"when" : 1234567890.123
}
```

### Stop Simulation

Stop the simulation at a specific point in time.

```json
{
	"action" : "stop",
	"when" : 1234567890.123
}
```

### Pause Simulation

Pause the simulation at a specific point in time.

```json
{
	"action" : "pause",
	"when" : 1234567890.123
}
```

### Resume Simulation

Resume the simulation at a specific point in time.

```json
{
	"action" : "resume",
	"when" : 1234567890.123
}
```