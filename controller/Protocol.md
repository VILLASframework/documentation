# Protocols {#controller-protocol}

This page documents the AMQP protocol used by VILLAScontroller to communicate.

We structure this protocol into three sections which cover the roles of simulators, gateway nodes (VILLASnode) and interfaces (VILLASweb).

# Topics {#controller-protocol-topics}

AMQP supports message routing based on topics. VILLAScontroller uses topics to direct messages to individual components or classes of them.

We define the following naming scheme for topics: `institution.project.role.role-type.uuid.action-group.action`.

With this scheme we can subscribe e.g. to all OPAL-RT simulators hosted by ACS within the Rt-SuperLab project: `acs.rtsuperlab.simulator.opalrt.#`.
Or we can subsribe to all simulators assigned to the project: `*.rtsuperlab.simulator.#`

# Roles

## Models

## Simulators {#controller-protocol-role-simulator}

**Role:** `simulator`  
**Sub-Types:**
 - `rtds`
 - `opalrt-rtlab`
 - `dpsim`
 - `modellica`

**Actions:**
 - `status.get`
 - `status.update`
 - `simulation.start`
 - `simulation.stop`
 - `simulation.pause`
 - `simulation.resume`
 - `model.upload`
 - `model.download`
 - `model.load`
 - `model.compile`

### Discover: `discover`

Request a status update from components. This will cause the component to reply with a `status.update` message.

```json
{ }
```

### Status Update: `status.update`

```json
{
    "status" : "idle",
    "model" : null
}
```

### Start Simulation: `simulation.start`

```json
{
    "model" : "model-id",
    "time" : 1234567890 /* UTC unix timestamp */
}
```

### Stop Simulation: `simulation.stop`

### Pause Simulation: `simulation.pause`

### Resume Simulation: `simulation.resume`

### Upload Model: `model.upload`

```json
{
    "model" : "model-uuid"
}
```

### Compile Model: `model.compile`

```json
{
    "model" : "model-uuid",
    "simulator" : "simulator-uuid"
}
```

### Load Model: `model.load`

```json
{
    "model" : "model-uuid"
    "simulator" : "simulator-uuid"
}
```

## Nodes {#controller-protocol-role-node}

**Role:** `node`

## Interface {#controller-protocol-role-interface}

**Role:** `interface`