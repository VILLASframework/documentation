# VILLASfpga {#fpga}

<img src="images/logos/villas_fpga.svg" width="100" align="right" />

 - @subpage fpga-setup
 - @subpage fpga-config
 - @subpage fpga-brainstorming

VILLASfpga interconnects simulators and devices under test (DUT) for hardware-in-the loop simulation using hard real-time capable interfaces.
VILLASfpga can guarantee fixed latencies in the nanosecond range.
VILLASfpga is using Xilinx' FPGA evaluation boards to interfaces such devices to each other and to the Linux host system via PCIexpress.

It implements intellectual property (IP) cores for connecting:

 - RTDS racks via their proprietary [GTFPGA](https://www.rtds.com/the-simulator/our-hardware/gtfpga-unit/) (aka `RTDS_InterfaceModule`)
 - OPAL-RT simulators and AixControl DSP racks via [Xilinx' Aurora](https://www.xilinx.com/products/intellectual-property/aurora8b10b.html).
 - Integration with all VILLASnode @ref node-node-types via PCIexpress and DMA transfers.
 - FPGA models built with
   - Simulink by using [Xilinx' System Generator](https://www.xilinx.com/products/design-tools/vivado/integration/sysgen.html).
   - C / C++ by using [Xilinx' High Level Synthesis](https://www.xilinx.com/products/design-tools/vivado/integration/esl-design.html).
 - Commercial inverters and HIL amplifiers via [EtherCAT](https://en.wikipedia.org/wiki/EtherCAT) (planned)

VILLASfpga can be configured to connect these interfaces in an arbitrary fashion without the need of generating a new bitstream. This is realized by using [a software configurable switch](https://www.xilinx.com/products/intellectual-property/axi4-stream_interconnect.html) in the FPGA fabric.

VILLASfpga is based on ARM's [AXI-4 Stream](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0051a/index.html) interfaces and therefore relying on Xilinx's Vivado toolchain. This limits the the range of supported FPGA families to Virtex 6, 7 and the newer Ultrascale devices.  Bitstreams for the [Xilinx VC707 FPGA evaluation board](https://www.xilinx.com/products/boards-and-kits/ek-v7-vc707-g.html) are available upon request.

## Repositories

The VILLASfpga project is splitted into two Git repositories:
- [VILLASfpga](https://git.rwth-aachen.de/acs/public/villas/fpga) contains the C++ driver library and a few example applications
- [VILLASfpga-hardware](https://git.rwth-aachen.de/acs/public/villas/fpga-hardware) contains the Xilinx FPGA design based on the Vivado


## Building

```bash
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
git clone  https://git.rwth-aachen.de/acs/public/villas/fpga
pushd VILLASfpga
git submodule update --init --recursive
mkdir -p thirdparty/libxil/build
pushd thirdparty/libxil/build
cmake ..
sudo make -j$(nproc) install
popd
mkdir build
cmake ..
sudo make -j$(nproc) install
ldconfig
```

## Running loopback test

Check that system is booted with IOMMU support:

```
find /sys | grep dmar
```

If not add `intel_iommu=on` to the kernel commandline and reboot.

```bash
sudo modprobe vfio
sudo modprobe vfio_pci

sudo VILLASfpga/build/src/villas-fpga-pipe 
```


## Available Bitstreams

@todo Coming soon
