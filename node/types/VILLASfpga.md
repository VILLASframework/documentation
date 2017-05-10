# VILLASfpga {#node-type-fpga}

**Important:** This documentation is outdated!

The GTFPGA card is an extension card for simulator racks from RTDS.
The manufacturer provides a VHDL module to exchange data via fiber optics between the GTFPGA and GPC cards.

The GTFPGA card is based on the Xilinx ML507 or ML605 evaluation boards.
This board consists of a Virtex 5 FPGA, Ethernet and Fiberoptic MACs and an hard macro PowerPC core.

This node type uses the PCIexpress bus to communicate with the FPGA cards.

# Configuration {#node-config-fpga}

Every `fpga` node support the following special settings:

## datamover (string: fpga-ip-name) {#node-config-fpga-datamover}

This must be the name of a FPGA IP instance as defined in the `fpgas[].ips` section of the configuration file.

This IP component is used to transfer samples between the FPGA and the main memory.

Currently two datamovers are supported:

- Direct Memory Access (DMA)
- AXI-Stream FIFO

## Example

```
fpgas = {
	vc707 = {
		/* Card identification */
		id = "10ee:7022";
		slot = "01:00.0";
		
		intc  = 0x5000;
		reset = 0x2000;
		do_reset = true;
		
		ips = {
			switch_0 = {
				vlnv = "xilinx.com:ip:axis_interconnect:2.1"
				baseaddr = 0x0000;
				numports = 3;
			},
			rtds_0 = {
				vlnv = "acs.eonerc.rwth-aachen.de:user:rtds_axis:1.0"
				baseaddr = 0x3000;
				port = 0;
			},
			dma_0 = {
				vlnv = "xilinx.com:ip:axi_dma:7.1";
				baseaddr = 0x1000;
				port = 2;
				irq = 0
			}
		}
		
		/* Configure switch_0 */
		paths = (
			{ in = "dma_0",  out = "rtds_0" },
			{ in = "rtds_0", out = "dma_0" }
		)
	}
}

nodes = {
	rtds = {
		datamover = "dma_0";
		use_irqs = false;
	}
}
```