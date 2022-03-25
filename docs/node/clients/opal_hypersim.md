---
sidebar_label: OPAL-RT HYPERSIM
title: OPAL-RT HYPERSIM
---

# OPAL-RT HYPERSIM <img align="right" width="250px" src="/img/logos/opal.jpg" alt="OPAL-RT logo"></img>

**Source code:** <http://git.rwth-aachen.de/acs/public/villas/node/tree/master/clients/hypersim>

[HYPERSIM](https://www.opal-rt.com/systems-hypersim/) is a digital real-time power system simulator developed by [OPAL-RT](http://opal-rt.com) and [Hydro Quebec](http://www.hydroquebec.com/international/en/technology/grid-simulation.html).

> HYPERSIM is a top-performance, fully digital simulator designed for in depth analysis of transient electromagnetic and electromechanical phenomena. It is used to analyze and validate power system control and protection circuits. HYPERSIM runs on SGI parallel supercomputers.

## Interfacing VILLASnode and HYPERSIM

**These instructions have been tested with HYPERSIM R6.1.3.o698.**

1. Create a new UCM name “node” and save to the real-time simulator folder of HYPERSIM.
   Example: `C:\Users\auser\HYPERSIM\ucm`.

	![](/img/screenshots/node/hypersim_1.png)

2. This will create a file name ucm_node.def

3. Open the file in editor and copy paste the downloaded code from the VILLASnode Git repository[VILLASnode/clients/hypersim/model/ucm_node.def](https://git.rwth-aachen.de/acs/public/villas/node/raw/develop/clients/hypersim/model/ucm_node.def)

4. Right click and update the code.

	![](/img/screenshots/node/hypersim_2.png)

5. Within the opening window, adjust the user settings
   - Destination Port number
   - Destination IP address

6. Go to options and set for real time

	![](/img/screenshots/node/hypersim_3.png)

7. Start simulation on HYPERSIM, and VILLASnode

8. The received data can be viewed on the ScopeView

	![](/img/screenshots/node/hypersim_4.png)

## Author

- Anju Meghwani <meghwani@iitk.ac.in>

Anju Meghwani is a Research Establishment Officer at Indian Institute of Kanpur, India and worked in Washington State University, Pullman as visiting scholar in Summer 2018.
During her visit, she developed an interfacing framework for VILLASnode and HYPERSIM.
This work was based on requirements of projects CREDC and UI-ASSIST.
UI- ASSIST is a joint research project between India and the US.
