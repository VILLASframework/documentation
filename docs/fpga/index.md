---
title: VILLASfpga
sidebar_position: 1
sidebar_label: Overview
---

# VILLASfpga <img src="/img/logos/villas_fpga.svg" width="100" align="right" />

VILLASfpga interconnects simulators and devices under test (DUT) for hardware-in-the-loop simulation using hard real-time-capable interfaces.
VILLASfpga can guarantee fixed latencies in the nanosecond range.
VILLASfpga uses Xilinx FPGA evaluation boards to interface such devices with each other and with the Linux host system via PCI Express.

It implements intellectual property (IP) cores for connecting:

- [GTFPGA](https://www.rtds.com/the-simulator/our-hardware/gtfpga-unit/) (aka `RTDS_InterfaceModule`)
  - RTDS 
- [Xilinx' Aurora](https://www.xilinx.com/products/intellectual-property/aurora8b10b.html).
  - OPAL-RT
  - RTDS
  - AixControl units
- Integration with all [VILLASnode node-types](../node/nodes/index.md) via PCIexpress and DMA transfers.
- FPGA models built with
  - Simulink by using [Xilinx' System Generator](https://www.xilinx.com/products/design-tools/vivado/integration/sysgen.html).
  - C / C++ by using [Xilinx' High Level Synthesis](https://www.xilinx.com/products/design-tools/vivado/integration/esl-design.html).

VILLASfpga can be configured to connect these interfaces in an arbitrary fashion without the need to generate a new bitstream. This is realized by using a [software-configurable switch](https://www.xilinx.com/products/intellectual-property/axi4-stream_interconnect.html) in the FPGA fabric.

VILLASfpga is based on ARM's [AXI-4 Stream](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0051a/index.html) interfaces and therefore relies on Xilinx's Vivado toolchain. This limits the range of supported FPGA families to Virtex 6, 7, and the newer Ultrascale devices. Bitstreams for the [Xilinx VC707 FPGA evaluation board](https://www.xilinx.com/products/boards-and-kits/ek-v7-vc707-g.html) are available upon request.

## Repositories

The VILLASfpga project is split into two Git repositories:
- [VILLASfpga](https://github.com/VILLASframework/fpga) contains the C++ driver library and a few example applications
- [VILLASfpga-hardware](https://github.com/VILLASframework/fpga-hardware) contains the Xilinx FPGA design based on Vivado

## Building

```shell
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
git clone  https://github.com/VILLASframework/fpga
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

```shell
find /sys | grep dmar
```

If not, add `intel_iommu=on` to the kernel command line and reboot.

```shell
sudo modprobe vfio
sudo modprobe vfio_pci

sudo VILLASfpga/build/src/villas-fpga-pipe 
```
