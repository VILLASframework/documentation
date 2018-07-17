# OPAL-RT HYPERSIM {#node-client-hypersim}

[HYPERSIM](https://www.opal-rt.com/systems-hypersim/) is a digital real-time power system simulator developed by [OPAL-RT](http://opal-rt.com) and [Hydro Quebec](http://www.hydroquebec.com/international/en/technology/grid-simulation.html).

> HYPERSIM is a top-performance, fully digital simulator designed for in depth analysis of transient electromagnetic and electromechanical phenomena. It is used to analyze and validate power system control and protection circuits. HYPERSIM runs on SGI parallel supercomputers.

## Interfacing VILLASnode and HYPERSIM

1. Create a new UCM name “node” and save to the real-time simulator folder of HYPERSIM.
   Example: `C:\Users\auser\HYPERSIM\ucm`.
	@image html hypersim_1.png width=100%

2. This will create a file name ucm_node.def

3. Open the file in editor and copy paste the downloaded code from the VILLASnode Git repository[VILLASnode/clients/hypersim/model/ucm_node.def](https://git.rwth-aachen.de/acs/public/villas/VILLASnode/raw/develop/clients/hypersim/model/ucm_node.def)

4. Right click and update the code
	@image html hypersim_2.png width=100%

5. Go to options and set for real time
	@image html hypersim_3.png width=100%

6. Start simulation on HYPERSIM, and VILLASnode

7. The received data can be viewed on the ScopeView
	@image html hypersim_4.png width=100%

## Author

- Anju Meghwani <ameghwani@gmail.com>
