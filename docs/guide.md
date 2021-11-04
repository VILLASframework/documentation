---
sidebar_position: 5
---

# Getting Started {#guide}

:::danger

This guide is currently under development.

:::

## Abstract

In this document, the user will be guided through the usual process of installing and configuring VILLASframwork.
The focus of this guide is to highlight the integration of VILLASframework components and to explain their interactions.

Please also have a look at the detailed guides for each component:

- [VILLASnode](node/guide.md)

## Architecture

![](/img/VILLAS_Standard_Setup.svg)

**TODO:** Describe role of components in a few sentences.

## Installation Steps

**TODO** Add example configurations and screenshots.

### On Simulation Node

1. Install your favourite Simulation Tool
  - [DPsim](https://git.rwth-aachen.de/acs/public/simulation/dpsim), OPAL-RT, RTDS, ...
2. Install VILLASnode as Gateway for Simulation Data
3. Configure VILLASnode to relay data between Simulator and MQTT Broker

### On Cloud Server

1. Install VILLASweb for Visualization / Control / Management
   - Use the [Demo Repo](https://git.rwth-aachen.de/acs/public/villas/demo) includes for a Docker setup including:
     - VILLASnode
     - VILLASweb
     - MongoDB as Database
     - RabbitMQ as MQTT Broker
1. Configure VILLASodne to relay data between MQTT Broker and Web Interface
1. Create Users
1. Create Simulator
1. Create Simulation
1. Create Simulation Model
1. Create Project
1. Create Visualization
