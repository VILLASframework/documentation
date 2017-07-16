# VILLASfpga {#fpga}

<img src="images/logos/villas_fpga.svg" width="100" align="right" />

 - @ref fpga-config

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
