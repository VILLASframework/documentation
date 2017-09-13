# Villas web data structure

## Description

This document describes how data (simulators, projecs etc. not only live data) is structured in Villas web.

## Main data classes

Villas web features 5 main data classes:

 - (Villas-)Nodes
 - Simulations
 - Projects
 - Visualizations
 - Users

Some of this data classes contain additional other data classes.

### Setup strategy

The easiest way to start from scratch is the following (assuming the simulators and villas-node are already configured):

1. Create a new node with at least one simulator.
2. Create a new simulation with the desired simulation models.
3. Create a new project with the simulation selected.
4. Create a new visualization and add widgets as desired.

### (Villas-)Nodes

In the simulator menu point, the user can view, create, edit and delete nodes to the system. Nodes are global at any time, which are shared with all users among Villas web. These nodes represent public villas-nodes, that are configured to stream live-data via websockets to the users. 

> Hint: At least *one* node is *required* to receive data in Villas web. 

Each node has simulators, which represent *one* (websocket-)node in the *villas-node configuration*. The simulator name **must** match the *websocket-node* in the *villas-node configuration* to connect to. If the names do not match, the *websocket-node* will not be fetched and data will not be received.

> Hint: At least one simulator is required to receive data in Villas web.

### Simulations

A simulation represents a *group* of *simulators* running specific *simulation models*, thus the same configuration of simulators can be shared with different projects. If you want to create a different group of simulators, create a new simulation.

To add a simulator to a simulation, add a new *simulation model* to the simulation, which represents the simulator connected a (villas-)node and the simulation model running on this simulator by setting the required signal count and mapping. The mapping must not be changed, but helps a lot to know which signal represents which live data.

> Hint: To be able to create a project, at least one simulation must be available.

### Projects

Projects represent the user's own usage of a simulation. To be able to use a simulation, create a new project and select the simulation you want to use.

> Hint: At the moment a project may only use one simulation, but this will change in future.

### Visualizations

Visualizations are the main part of Villas web. They represent the live data. Visualizations are added to a project and can show the data for the simulation that is assigned to this project. To view data, edit the visualization and add widgets to it. Different widgets are available to represent the data in the different ways. In the widget options you can select from which simulator the widgets should fetch their data (individual for each widget).