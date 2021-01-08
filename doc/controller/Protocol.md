# Protocol {#controller-protocol}

This page documents the data model/protocol used by VILLAScontroller to control and monitor infrastructure components (IC).
The protocol uses AMQP to transport JSON encoded objects which are specified in the following document.

VILLAScontroller is implemented in Python and using the [Kombo messaging package](https://kombu.readthedocs.io).

The Git repository is available at: http://git.rwth-aachen.de/acs/public/villas/controller

## Entities {#controller-protocol-entities}

The puporse of VILLAScontroller is the orchestration of IC in distributed lab setups.
This includes the following tasks:

- managment: instantiation, deletion & discovery
- monitoring: status?
- control: start, stop, pause, reset, resume, shutdown

For the purpose of routing and grouping the IC, we introduce the following categories:

- `simulator` (_implemented_)
- `simulation` (_planned_)
- `interface` (_planned_)
- `gateway` (_planned_)
- `model` (_planned_)

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
	- `controller` (manages ICs, e.g. Kubernetes)
	- `service` (virtual SW, e.g. energy management system)
    - `gateway` (e.g. VILLASnode, e.g. VILLASrelay)
    - `equipment` (e.g. HIL Interfaces: Chroma, Fleps, PGS; DuT: Battery, PV-Inverter, Lab-equipment: Programmable supplies and loads)

- `type` further defines the type/vendor of a device within its class.
  - For `simulator`:
    - `dummy` (_implemented_)
    - `generic` (_implemented_)
    - `dpsim` (_WIP_)
    - `rtlab` (_planned_)
    - `rscad` (_planned_)
  - For `gateway`:
    - `villas-node` (_implemented_)
    - `villas-relay` (_implemented_)
  - For `controller`:
    - `kubernetes`
    - `villas-controller`
  - For `service`:
	- `ems`
	- `custom`?
  - For `equipment`:
	- `chroma-emulator`
	- `chroma-loads`
	- `sma-sunnyboy`
	- `fleps`
	- `sonnenbatterie`

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

## State Machine

@htmlonly
<div class="mermaid">
stateDiagram-v2
    [*] --> State1
    state State1 {
      [*] --> idle
      idle --> starting: start
      starting --> running
      running --> stopping: stop
      stopping --> stopped
      running --> pausing: pause
      pausing --> paused
      paused --> stopping: stop
      paused --> resuming: resume
      resuming --> running
    }
    State1 --> resetting: reset
    resetting --> State1
    State1 --> shuttingdown: shutdown
    shuttingdown --> [*]
    State1 --> error: exception
    error --> resetting: reset
</div>
@endhtmlonly

## Management

### Discovery

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

### Status Update

```json
{
	"status" : {
		"version" : "0.1.0",
		"state" : "idle",
		"run-id" : "run-id",
		"name" : "OP5600",
		"description" : "some optional description",
		"location" : "OPAL-RT Rack, ACS Real-time Lab, EONERC, RWTH",
		"owner" : "stvogel@eonerc.rwth-aachen.de",
		"uptime" : 123124.0 /* in seconds since initialization (float) */,
		"ws_url" : "https://villas-new.k8s.eonerc.rwth-aachen.de/ws/relay/node_1",
		"api_url" : "https://villas-new.k8s.eonerc.rwth-aachen.de/ws/relay/api/node_1"
	},
	"time" : 1234567890.123 /* timestamp in seconds (UTC / Unix epoch / since 1970-01-01) (float) */
}
```

Used values for `state`:

- `gone` (issued once after `action = delete`)
- `error`
- `idle`
- `starting`
- `running`
- `pausing`
- `paused`
- `resuming`
- `stopping`
- `resetting`
- `shuttingdown`
- `shutdown`

## Management

### Instantiation

```json
{
	"action": "create",
	"when": 1234567890.123,
	"parameters": {
		"key": "value",
		"key2": { }
	}
}
```

### Deletion

```json
{
	"action": "delete",
	"when": 1234567890.123,
}
```

## Control

### Reset

```json
{
	"action" : "reset",
	"when" : 1234567890.123
}
```

### Shutdown

```json
{
	"action" : "shutdown",
	"when" : 1234567890.123
}
```

### Start

Start the simulation at a specific point in time.

```json
{
	"action" : "start",
	"parameters" : {
	    "timestep" : 50e-6,
	    "duration" : 10,
	    "domain" : "dp",
	    "downsample" : 1
	},
	"model" : { // HTTP GET for model download
		"type": "url",
		"url" : "https://villas.k8s.eonerc.rwth-aachen.de/api/v2/files/123421",
		"token": "Xwlsjkdlfksjhdfglskdfg"
	},
	"results" : { // HTTP POST for results upload
	    "type" : "url"
	    "url" : "https://villas.k8s.eonerc.rwth-aachen.de/api/v2/runs/3452345234/results"
		"token": "Xwlsjkdlfksjhdfglskdfg"
	},
	"when" : 1234567890.123
}
```

Another example for `type = generic`:

```json
{
	"action" : "start",
    "parameters" : {
        "executable" : "ping",
        "argv" : [
            "google.de",
            "-c", "10"
        ],
        "working_directory" : "/tmp/simulationX",
        "shell" : false,
        "environemnt" : [
            "DEBUG" : "1"
        ]
    },
	"when" : 1234567890.123
}
```

### Stop

Stop the simulation at a specific point in time.

```json
{
	"action" : "stop",
	"when" : 1234567890.123
}
```

### Pause

Pause the simulation at a specific point in time.

```json
{
	"action" : "pause",
	"when" : 1234567890.123
}
```

### Resume

Resume the simulation at a specific point in time.

```json
{
	"action" : "resume",
	"when" : 1234567890.123
}
```
