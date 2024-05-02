---
sidebar_label: OPAL-RT HYPERSIM
title: OPAL-RT HYPERSIM
---

# OPAL-RT HYPERSIM <img align="right" width="250px" src="/img/logos/opal.jpg" alt="OPAL-RT logo"></img>

**Source code:** <https://github.com/VILLASframework/node/tree/master/clients/hypersim>

[HYPERSIM](https://www.opal-rt.com/systems-hypersim/) is a digital real-time power system simulator developed by [OPAL-RT](http://opal-rt.com) and [Hydro Quebec](http://www.hydroquebec.com/international/en/technology/grid-simulation.html).

> HYPERSIM is a top-performance, fully digital simulator designed for in depth analysis of transient electromagnetic and electromechanical phenomena. It is used to analyze and validate power system control and protection circuits. HYPERSIM runs on SGI parallel supercomputers.

## Interfacing VILLASnode and HYPERSIM

:::note
These instructions have been tested with HYPERSIM 2023.2.0.o389.
:::

:::important
An OPAL-RT System using a  Redhat OS is required. 
:::

1. Create a new UCM name “node” and save to the real-time simulator folder of HYPERSIM.
   Example: `C:\Users\auser\HYPERSIM\ucm`.

<figure align="center">
    <img alt="Add UCM block to HYPERSIM" src="/img/screenshots/node/opal-hypersim/hypersim_1.png" width="100%" />
    <figcaption>Add UCM block to HYPERSIM.</figcaption>
</figure>

2. This will create a file name ucm_node.def

3. Open the file in editor and copy paste the downloaded code from the VILLASnode Git repository [VILLASnode/clients/hypersim/model/ucm_node.def](https://github.com/VILLASframework/node/blob/master/clients/hypersim/model/ucm_node.def)

4. Right click and update the code.

<figure align="center">
    <img alt="Update the UCM code" src="/img/screenshots/node/opal-hypersim/hypersim_2.png" width="100%" />
    <figcaption>Update the UCM code.</figcaption>
</figure>

5. Within the opening window, adjust the user settings
   - Destination Port number
   - Destination IP address

6. Go to options and set for real time

<figure align="center">
    <img alt="Enable real-time settings" src="/img/screenshots/node/opal-hypersim/hypersim_3.png" width="100%" />
    <figcaption>Enable real-time settings.</figcaption>
</figure>

7. Start simulation on HYPERSIM, and VILLASnode

8. The received data can be viewed on the ScopeView

<figure align="center">
    <img alt="Inspect data in ScopeView" src="/img/screenshots/node/opal-hypersim/hypersim_4.png" width="100%" />
    <figcaption>Inspect data in ScopeView.</figcaption>
</figure>

## Screenshot

<figure align="center">
    <img alt="HYPERSIM model with VILLASnode UCM block" src="/img/screenshots/node/opal-hypersim/hypersim_ucm_schematic.png" width="100%" />
    <figcaption>HYPERSIM model with VILLASnode UCM block.</figcaption>
</figure>

## Limitations

Currently, the number if input/output control signals is hard-coded to 7 in the UCM-code.
This can be adjusted by manually changing the UCM-code and rebuilding the model.

## Troubleshooting

###  `ERROR: Unable to execute RPC call`

```
*** ERROR: Unable to execute RPC call to host RTServer program 0x3ff00115 service HS_RPC_COMMAND_EXECUTE Status
Unable to connect to simulation for user XXXXX on MTL-L-04439:1 IP-Address
```

**Work around:** Clean shared memories of your target or restart target.

## Authors

- Anju Meghwani <meghwani@iitk.ac.in>
- Louis Birkner <louis.birkner@opal-rt.com>