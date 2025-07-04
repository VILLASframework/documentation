# Protocol

This page documents the data model/protocol used by VILLAScontroller to control and monitor infrastructure components (ICs).
The protocol uses AMQP to transport JSON-encoded objects, which are specified in the following document.

VILLAScontroller is implemented in Python and using the [Kombo messaging package](https://kombu.readthedocs.io).

The Git repository is available at: http://github.com/VILLASframework/controller

The purpose of VILLAScontroller is the orchestration of IC in distributed lab setups.
This includes the following tasks:

- management: instantiation, deletion & discovery
- monitoring: status?
- control: start, stop, pause, reset, resume, shutdown

## Entities

For the purpose of addressing the ICs, we introduce the following categories (1st level) and types (2nd level): 

- `simulator`
  - `dpsim`
  - `generic`
  - `rtlab`
  - `rtds`
  - `dummy`
  - `kubernetes` (a [Kubernetes Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/))
- `gateway`
  - `villas-node`
  - `villas-relay`
- `manager`
  - `villas-node`
  - `villas-relay`
  - `generic`
  - `kubernetes`

These component types are implemented by the following class hierarchy in VILLAScontroller's Python code:

```mermaid
classDiagram
      Component <-- Manager
      Component <-- Gateway
      Component <-- Simulator
      Simulator <-- DPsimSimulator
      Simulator <-- RTlabSimulator
      Simulator <-- DummySimulator
      Simulator <-- DummySimulator
      Simulator <-- KubernetesJob
      Manager <-- GenericManager
      Manager <-- VILLASnodeManager
      Manager <-- VILLASrelayManager
      Manager <-- KubernetesManager
      Gateway <-- VILLASnodeInterface
      Gateway <-- VILLASrelaySession
```

## Exchange

All messages processed by VILLAScontroller are sent via an AMQP `headers` exchange.

The exchange is named `villas`.

## Routing

The following headers are used to identify and route messages to the recipients:

- `realm` describes the entity that is responsible for operating the equipment.
  The realm should be a fully qualified domain name (FQDN) in reverse order.
  - Examples:
    - `de.rwth-aachen.eonerc.acs`
    - `gov.inl`

- `category` describes the classes of equipment.
  - Examples:
    - `simulator`
	- `manager` (manages ICs, e.g. Kubernetes Jobs, VILLAS WebSocket endpoints)
    - `gateway` (e.g. VILLASnode, e.g. VILLASrelay)

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

Example of an application header:

```json
{
	"realm" : "de.rwth-aachen.eonerc.acs",
	"category" : "simulator",
	"type" : "rtlab",
	"uuid" : "56babc1e-0476-11e8-9375-471525328a77"
}
```

**Important:** Note that at least one of the headers must be provided. Otherwise no component will receive it.

It is also valid to just provide a single header (e.g. `uuid` to address a specific component or `type` to address a class of components).

## State Machine

```mermaid
stateDiagram-v2
    [*] --> State1
    state State1 {
      [*] --> idle
      idle --> starting: start
      starting --> running
      running --> stopping: stop
      running --> pausing: pause
      pausing --> paused
      paused --> stopping: stop
      stopping --> idle
      paused --> resuming: resume
      resuming --> running
    }
    State1 --> resetting: reset
    resetting --> State1
    State1 --> shuttingdown: shutdown
    shuttingdown --> [*]
    State1 --> error: exception
    error --> resetting: reset
```

## Management

### Discovery

In a messaging protocol like AMQP, brokers do not store message contents in a persistent way.
They only temporarily queue messages until they have been delivered.
Therefore, the broker cannot keep track of the state or presence of entities.

This section describes a simple discovery mechanism to work around this limitation.
Each entity must react on `action = ping` messages and respond immediately with a status response message.

```json
{
	"action" : "ping"
}
```

After receiving such a message, each entity shall send a status update message as described below.

### Status Update

```json
{
	"status" : {
		/* Generic state */
		"state" : "running",
		"version" : "0.1.0",                 /* VILLAScontroller version */
		"uptime" : 123124.0,                 /* in seconds since initialization (float) */
		"error": {                           /* only present if state == "error" */
			"message": "This is an error message",
			"code": 1234
		},

		"managed_by": "4af1cf3a-7e80-11eb-a7f4-b700f4a4f18d", /* link to managing IC of category 'manager' */

		/* Custom state (depending on IC type) */
		"villas_node_version": "v0.11.0",
		"kernel": ["Linux", "villas-node-594f8c7bff-wmznc", "5.0.0-29-generic", "#31~18.04.1-Ubuntu SMP Thu Sep 12 18:29:21 UTC 2019", "x86_64"],
		"host": "villas-node-594f8c7bff-wmznc"
	},
	"properties": { /* fixed configuration of IC as provided by user */

		/* Generic properties */
		"name" : "OP5600",
		"description" : "some optional description",
		"location" : "OPAL-RT Rack, ACS Real-time Lab, EONERC, RWTH",
		"owner" : "post@steffenvogel.de",

		"ws_url" : "https://villas.k8s.eonerc.rwth-aachen.de/ws/relay/node_1",
		"api_url" : "https://villas.k8s.eonerc.rwth-aachen.de/ws/relay/api/node_1",

		/* Custom properties (depending on IC type) */
		"opal_hostname": "opal-op5600.acs-lab.eonerc.rwth-aachen.de"
		"namespace": "villas"
		"job_name": "My_Kubernetes_Simulator"
		"pod_names": ["pod_number_1", "pod_number_2"]

		/* Signal description in the same format as used by VILLASnode:
		 * https://github.com/VILLASframework/node/blob/master/doc/openapi/components/schemas/config/signal_list.yaml
		 */
		"signals": [
			{ "name": "voltage_bus123_phase1", "unit": "V", "type": "float" },
			{ "name": "voltage_bus123_phase2", "unit": "V", "type": "float" },
			{ "name": "voltage_bus123_phase3", "unit": "V", "type": "float" }
		]
	},
	"schema": {
		"start": {
			/* JSON-Schema describing start parameters. */
		},
		"create": {
			/* JSON-Schema describing properties of new ICs created via create action (targeted at ICs of category=manager). */
		}
	},
	"when" : 1234567890 /* timestamp in seconds (UTC / Unix epoch / since 1970-01-01) (float) */
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

### Creation of new components

**Important:** This action type must be directed at a component of category `manager`!

```json
{
	"action": "create",
	"when": 1234567890,
	"parameters": {
		"name": "DPsim simulator",
		"location": "ACS lab",
		"realm": "de.rwth-aachen.eonerc.acs",
		"category": "simulator",
		"type": "dpsim"
		"uuid": "c487a470-6af6-11eb-beee-7fa268050404",
		"properties": {
			"myproperty": 1234
		}
	}
}
```

The `uuid` parameter is optional. If not provided, the managing component will generate a random one.

### Deletion of components

**Important:** This action type must be directed at a component of category `manager`!

```json
{
	"action": "delete",
	"parameters": {
		"uuid": "c487a470-6af6-11eb-beee-7fa268050404"
	}
	"when": 1234567890,
}
```

## Control

### Reset

```json
{
	"action" : "reset",
	"when" : 1234567890
}
```

### Shutdown

```json
{
	"action" : "shutdown",
	"when" : 1234567890
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
		"type": "url-list",
		"url" : [
			"https://villas.k8s.eonerc.rwth-aachen.de/api/v2/files/123421",
			"https://villas.k8s.eonerc.rwth-aachen.de/api/v2/files/123422"
		],
		"token": "Xwlsjkdlfksjhdfglskdfg"
	},
	"results" : { // HTTP POST for results upload
	    "type" : "url"
	    "url" : "https://villas.k8s.eonerc.rwth-aachen.de/api/v2/runs/3452345234/results"
		"token": "Xwlsjkdlfksjhdfglskdfg"
	},
	"when" : 1234567890
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
        "environment" : [
            "DEBUG" : "1"
        ]
    },
	"when" : 1234567890
}
```

### Stop

Stop the simulation at a specific point in time.

```json
{
	"action" : "stop",
	"when" : 1234567890
}
```

### Pause

Pause the simulation at a specific point in time.

```json
{
	"action" : "pause",
	"when" : 1234567890
}
```

### Resume

Resume the simulation at a specific point in time.

```json
{
	"action" : "resume",
	"when" : 1234567890
}
```
