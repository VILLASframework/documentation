# VILLASfpga {#node-type-fpga}

@todo This node-type is currently under development.

VILLASfpga is an extension build on top of VILLASnode for realizing hard real-time interfaces between simulators, converters and devices under test with guaranteed cycle times in the microsecond range.

Please look at the main page for details: @ref fpga.

## Prerequisites {#node-type-zeromq-prereq}

This node-type requires the [VILLASfpga](https://git.rwth-aachen.de/acs/public/villas/fpga/fpga) library.

## Implementation {#node-type-zeromq-implementation}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/fpga.cpp

## Configuration {#config}

The node configuration is used to define interfaces between the FPGA and Linux host system by means of so called datamover.
A datamover is a special IP core within the FPGA which handles data exchange between the FPGA's AXI4-Stream fabric and the main memory of the host system.

Currently, two types of data movers are supported:

 - [DMA controllers](https://www.xilinx.com/products/intellectual-property/axi_dma.html)
   - in Scatter / Gather mode.
   - in simple Register mode.
 - [FIFOs](https://www.xilinx.com/products/intellectual-property/axi_fifo.html)

Every `fpga` node support the following special settings:

### datamover (string: fpga-ip-name) {#node-config-node-fpga-datamover}

The must be the name of a FPGA IP core as defined in @ref fpga-config-ip.

This IP component is used to transfer samples between the FPGA and the main memory.

### card (string: fpga-card-name) {#node-config-node-fpga-card}

The name of the FPGA card as configured by @ref fpga-config-card.

### user_irqs (boolean) {#node-config-node-fpga-use_irqs}

Weather or not to polling / interrupts to wait for new samples from the FPGA.

## Example {#node-type-fpga-example}

@todo Add example config
