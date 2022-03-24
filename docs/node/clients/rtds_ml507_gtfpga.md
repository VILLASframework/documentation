---
sidebar_label: RTDS GTFPGA UDP
---

# RTDS GTFPGA UDP <img align="right" width="150px" src="/img/logos/rtds.jpg" alt="RTDS Technologies logo"></img>

The Xilinx ML507 FPGA board can be used as alternative to RTDS GTNET cards.

The FPGA board is connected via fiber optics to the RTDS rack and via Ethernet to the VILLASnode machine.

### Flashing of GTFPGA card

The GTFPGA card is basically just a Xilinx ML507 evaluation board running a special firmware which is based on the *RTDS_InterfaceModule* provided by RTDS.

The code running on the GTFPGA board is divided into two parts:

 1. Software running on the embedded PowerPC 440 processor which handling the UDP/IP communication by using the LWIP network stack.
 2. Hardware / FPGA bitstream for the Virtex5 FGPA for connecting the DDR RAM and SFP ports to the PowerPC core by using a PLB bus.

#### Generating the FPGA bitstream

To generate the FPGA bitstream "Xilinx XPS 12.4" **must** be used. Please make sure to exactly use this version!

#### Compiling the PowerPC software

To generate the software binary "Xilinx SDK 12.4" **must** be used. Please make sure to exactly use this version!

#### Generate SystemACE images for the CompactFlash card

The Xilinx ML507 board supports to load it's initial configuration (hardware and software) from a Compact Flash memory card.
This is an easy way to get the GTFPGA card running without using the Xilinx tools to program the FPGA.

By default, the GTFPGA will load it's default configuration (IP address, port, rate) from above.

#### Manually programming the GTFPGA by using a Xilinx Platform USB Cable

Alternatively, the GTFPGA can be programmed by using a Xilinx Platform USB Programming cable.
Please note that you have to configure / program the FPGA after every power cycle.
The configuration of the FPGA is not persistent!
