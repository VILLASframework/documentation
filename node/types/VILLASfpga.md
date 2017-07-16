# VILLASfpga {#node-type-fpga}

VILLASfpga is an extension build on top of VILLASnode for realizing hard real-time interfaces between simulators, converters and devices under test with guaranteed cycle times in the microsecond range.

VILLASfpga is using Xilinx' FPGA evaluation boards to interfaces such devices to each other and to the Linux host system via PCIexpress.

It implements intellectual property (IP) cores for connecting:

 - RTDS racks via their proprietary [GTFPGA](https://www.rtds.com/the-simulator/our-hardware/gtfpga-unit/) (aka `RTDS_InterfaceModule`)
 - OPAL-RT simulators and AixControl DSP racks via [Xilinx' Aurora](https://www.xilinx.com/products/intellectual-property/aurora8b10b.html).
 - Integration with all VILLASnode @ref node-types via PCIexpress and DMA transfers.
 - FPGA models built with
   - Simulink by using [Xilinx' System Generator](https://www.xilinx.com/products/design-tools/vivado/integration/sysgen.html).
   - C / C++ by using [Xilinx' High Level Synthesis](https://www.xilinx.com/products/design-tools/vivado/integration/esl-design.html).
 - Commercial converters via [EtherCAT](https://en.wikipedia.org/wiki/EtherCAT) (planned)

Like it's software counterpart, VILLASfpga can be configured to connect these interfaces in an arbitrary fashion without the need of generating a new bitstream. This is realized by using [a software configurable switch](https://www.xilinx.com/products/intellectual-property/axi4-stream_interconnect.html) in the FPGA fabric.

VILLASfpga is based on ARM's [AXI-4 Stream](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0051a/index.html) interfaces and therefore relying on Xilinx's Vivado toolchain. This limits the the range of supported FPGA families to Virtex 6, 7 and the newer Ultrascale devices.  Bitstreams for the [Xilinx VC707 FPGA evaluation board](https://www.xilinx.com/products/boards-and-kits/ek-v7-vc707-g.html) are available upon request.

# Configuration {#node-config-fpga}

VILLASfpga is configured via the standard VILLASnode configuration file.
Unlike the other node-types, the `fpga` node-type requires settings in two places:

- FPGA card configuration
- Datamover / Node configuration

## FPGA Card {#fpga-config-card}

This section is a group (like `nodes`) which allows the user to use multiple FPGA devices at the same time.
Like @ref node-concept-node, each FPGA has it's own name / identifier:

### id (string) {#fpga-config-card-id}

### slot (string) {#fpga-config-card-slot}

### intc (integer: base address) {#fpga-config-card-intc}

### reset (integer: base address) {#fpga-config-card-reset}

### do_reset (boolean) {#fpga-config-card-do_reset}

### paths (array of groups) {#fpga-config-card-paths}

### Example

```
fpgas = {
	vc707 = {
		/* Card identification */
		id = "10ee:7022";
		slot = "01:00.0";

		intc  = 0x5000;
		reset = 0x2000;
		do_reset = true;

		/* Configure switch_0 */
		paths = (
			{ in = "dma_0",  out = "rtds_0" },
			{ in = "rtds_0", out = "dma_0" }
		)
	}
}
```

## FPGA IP core {#fpga-config-ip}

Each FPGA IP core requires at least the following setting.
Depending on the [VLNV](https://www.xilinx.com/support/answers/50478.html) of each IP core, additional settings can be configured.

### vlnv (string: "vendor:library:name:version:) {#fpga-config-ip-vlnv}

A [VLNV](https://www.xilinx.com/support/answers/50478.html) identifier to properly identify the version and type of this IP core.

### baseaddr (integer: baseaddr) {#fpga-config-ip-baseaddr}

The base address for register access.

### port (integer) {#fpga-config-ip-port}

The port number of a switch to which this IP core is connected.

### Example

```
fpgas = {
	vc707 = {
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
	}
}
```

## Node / Datamover {#node-config-fpga}

The node configuration is used to define interfaces between the FPGA and Linux host system by means of so called datamover.
A datamover is a special IP core within the FPGA which handles data exchange between the FPGA's AXI4-Stream fabric and the main memory of the host system.

Currently, two types of data movers are supported:

 - [DMA controllers](https://www.xilinx.com/products/intellectual-property/axi_dma.html)
   - in Scatter / Gather mode.
   - in simple Register mode.
 - [FIFOs](https://www.xilinx.com/products/intellectual-property/axi_fifo.html)

Every `fpga` node support the following special settings:

## datamover (string: fpga-ip-name) {#node-config-fpga-datamover}

The must be the name of a FPGA IP core as defined in @ref fpga-config-ip .

This IP component is used to transfer samples between the FPGA and the main memory.

### card (string> fpga-card-name) {#node-config-fpga-card}

The name of the FPGA card as configured by @ref fpga-config-card.

### user_irqs (boolean) {#node-config-fpga-use_irqs}

Weather or not to polling / interrupts to wait for new samples from the FPGA.

### Example

nodes = {
	rtds = {
		type = "fpga",

		card = "vc707",
		datamover = "dma_0",
		use_irqs = false
	}
}
```
