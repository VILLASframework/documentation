# Protocols {#controller-protocol}

This page documents the protocol used by VILLAScontroller to control and monitor simulators.
The protocol uses AMQP to transport JSON encoded objects which are specified in the following document.

We structure this protocol into three sections which cover the roles of simulators, gateway nodes (VILLASnode) and interfaces (VILLASweb).

# Topics {#controller-protocol-topics}

AMQP supports message routing based on topics. VILLAScontroller uses topics to direct messages to individual components or classes of them.

We define the following naming scheme for topics: `realm.role.uuid`.

With this scheme we can subscribe e.g. to all OPAL-RT simulators within the Rt-SuperLab project: `rtsuperlab.simulator.#`.
Or we can subsribe to all simulators assigned to the project: `rtsuperlab.simulator.#`

# Auto-discovery

All Roles should respond to the following RPC request with a status message:

## Discover: `discover`

Request a status update from components. This will cause the component to reply with a `status.update` message.

```json
{ }
```


# Roles

## Models

**Role:** `model`

### Upload Model: `model.upload`

```json
{
    "model" : "model-uuid"
}
```

### Load Model: `model.load`

```json
{
    "model" : "DFADF953-8F38-4862-959C-ACF2662D9B7A", # A UUID
    "name" : "A name of the model shown in the log files / interfaces",
    "description" : "A more detailed description of the model"
    "url" : "http://web.villas.fein-aachen.org/models/DFADF953-8F38-4862-959C-ACF2662D9B7A.zip"
}
```

### Compile Model: `model.compile`

```json
{
    "model" : "DFADF953-8F38-4862-959C-ACF2662D9B7A"
}
```

### Clean Model: `model.clean`

Destroy and delete all model data on the simulation node.

## Simulators {#controller-protocol-role-simulator}

**Role:** `simulator`

**Actions:**
 - `status`
 - `status.update`
 - `model.upload`
 - `model.download`
 - `model.load`
 - `model.compile`

### Status Update: `status`

```json
{
    "status" : "idle",
    "location" : "ACS Real-time lab",
    "simulation" : null /* Currently loaded simulation */
}
```

## Simulation

**Role:** `simulation`

### Start Simulation: `start`

Start the simulation at a specific point in time.

```json
{
    "time" : 1234567890 /* UTC unix timestamp */
}
```

### Stop Simulation: `stop`

Stop the simulation at a specific point in time.

```json
{
    "model" : "model-id",
    "time" : 1234567890 /* UTC unix timestamp */
}
```

### Pause Simulation: `pause`

Pause the simulation at a specific point in time.

```json
{
    "model" : "model-id",
    "time" : 1234567890 /* UTC unix timestamp */
}
```

### Resume Simulation: `simulation.resume`

Resume the simulation at a specific point in time.

```json
{
    "model" : "model-id",
    "time" : 1234567890 /* UTC unix timestamp */
}
```

## Nodes {#controller-protocol-role-node}

**Role:** `node`

## Interface {#controller-protocol-role-interface}

**Role:** `interface`