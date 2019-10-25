# Getting Started with VILLASweb {#web-guide}

This document describes setting up a demo in VILLASweb to test it's features. It is assumed that the docker-compose.yml file in VILLASweb repository is used (otherwise setup the website, backend with database and a villasnode which sends data).

## Configure VILLASnode

### Install VILLASnode

See: @ref node-installation

### Create a new dummy data source

1. Create a new empty configuration file with the following contents:

@includelineno node/etc/examples/villas-web.conf

**Note:** Please exchange the node name `test_node_1` to something unique in order to avoid conflicts with other users.

### Start the VILLASnode gateway

1. Run the following command:

```bash
villas node /opt/VILLASnode/etc/examples/villas-web.conf
```

**Note:** Change to path to the configuration file accordingly.

## Configure VILLASweb

1. Access the public VILLASweb demo instance at: https://web.villas.fein-aachen.org

### Create a new Simulator

1. Go to 'Simulators' in the main menu.
  1. Add a new simulator by clicking on 'New Simulator'
    1. Enter any name for the simulator, set the simulator ID to '1' and the endpoint to '/ws/relay/test_node_1'.
    2. Click on 'Create'.

### Create a new Simulation

1. Go to 'Simulations' in the main menu.
  1. Add a new simulation by clicking on 'New Simulation'.
    1. Enter any name for the simulation and click on 'Create'.
    2. Click on 'Running' in the table view beside the new simulation.
      1. Select 'running' in the drop-down menu and click on 'Save'.
    3. Click on the created simulation in the table view.
    4. Every simulation must have at least one simulation model to receive data. Each simulation model represents a simulator for that simulation.
    5. Add a new simulation model by clicking on 'New model'.
      1. Enter any name for the model, select the simulator in the drop-down menu and set the length to '3' (length is the number of values received by the simulator).
      2. Click on 'Create'.
      3. Click on the created model in the table view.
      4. Enter any names for the signals in the simulation model (optional).

### Create a new Project

1. Go to 'Projects' in the main menu.
  1. Add a new project by clicking on 'New Project'.
    1. Enter any name and select the simulation used by this project in the drop-down menu.
    2. Click on 'Create' and afterwards on the created project in the table view.
    3. Add a new visualization by clicking on 'New visualization'.
      1. Enter any name for the visualization and click on 'Create'.
      2. Click on the created visualization in the table view.
      3. Click on 'Edit layout' in the view.
      4. Add widgets by dragging them to the dotted area. The dropped widgets can be moved and resized with the mouse. Access widget options by double clicking them.
      5. Click on 'Save' to view the created visualization.