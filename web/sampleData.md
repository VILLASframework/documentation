# Setup sample data {#web-sampledata}

## Description

This document describes setting up sample data in VILLASweb to test it's features. It is assumed that the user is logged in with admin permissions.
Also the VILLASweb-socket testing tool is assmued running on port 4000 on the local computer.

## Instructions

1. Go to 'Simulators' in the main menu.
  1. Add a new simulator by clicking on 'New Simulator'
    1. Enter any name for the simulator, set the simulator ID to '1' and the endpoint to 'localhost:4000'.
    2. Click on 'Create'.
2. Go to 'Simulations' in the main menu.
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
3. Go to 'Projects' in the main menu.
  1. Add a new project by clicking on 'New Project'.
    1. Enter any name and select the simulation used by this project in the drop-down menu.
    2. Click on 'Create' and afterwards on the created project in the table view.
    3. Add a new visualization by clicking on 'New visualization'.
      1. Enter any name for the visualization and click on 'Create'.
      2. Click on the created visualization in the table view.
      3. Click on 'Edit layout' in the view.
      4. Add widgets by dragging them to the dotted area. The dropped widgets can be moved and resized with the mouse. Access widget options by double clicking them.
      5. Click on 'Save' to view the created visualization.
