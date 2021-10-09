# Configuration {#fpga-config}

**Warning:** Section is outdated

VILLASfpga is configured via the standard VILLASnode configuration file.
Unlike the other node-types, the `fpga` node-type requires settings in two places:

- Configuration of the FPGA: @ref fpga-config-card
- Configuration of the VILLASnode / VLLASfpga interface: @ref node-config-fpga

## FPGA Card {#fpga-config-card}

This section is a group (like `nodes`) which allows the user to use multiple FPGA devices at the same time.
Like nodes, each FPGA has it's own name:

### id (string: "vendor:product") {#fpga-config-card-id}

A string containing the vendor and product of the FPGA card as shown by `lscpi`.

### slot (string) {#fpga-config-card-slot}

The slot in which the FPGA card is located as shown by `lspci`.

### intc (integer: base address) {#fpga-config-card-intc}

The AXI4-Lite base address used to access registers of the interrupt controller.

### reset (integer: base address) {#fpga-config-card-reset}

The AXI4-Lite base address used to access registers of the reset controller.

### do_reset (boolean) {#fpga-config-card-do_reset}

Should VILLASnode perform a reset of the FPGA board when started?

### paths (array of groups) {#fpga-config-card-paths}

A list of connections within the FPGA fabric which should be configured.
This is analog to the @ref node-config-path setting of VILLASnode.

### Example

<!-- convert to JSON -->
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

<!-- convert to JSON -->
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
