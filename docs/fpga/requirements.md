# Requirements

## Hardware

- Xilinx evaluation board
    - [VC707 (EK-V7-VC707-G)](https://www.xilinx.com/products/boards-and-kits/ek-v7-vc707-g.html)
    - [ZCU106 (EK-U1-ZCU106-G)](https://www.xilinx.com/products/boards-and-kits/zcu106.html)

- FMC SFP extension module
    - [Faster Technologies FM-S18](https://www.fastertechnology.com/products/fmc/fm-s18.html)

- PCIe extension kit
    - [One Stop Systems PCIe x8 Gen3 Embedded Cable Adapter](https://onestopsystems.com/products/pcie-x8-gen3-embedded-cable-adapter)
    - [One Stop Systems PCIe x8 Cable](https://onestopsystems.com/products/pcie-x8-cable)
    - [One Stop Systems PCIe x8 Gen3 Dual Port Cable Adapter](https://onestopsystems.com/collections/pcie-cable-adapters/products/pcie-x8-gen3-dual-port-cable-adapter)
    - Additional ATX Power Supply

## Software

- **Operating System:** Linux
- **Distribution:** Redhat Enterprise Linux, Fedora or Rocky Linux
- **Kernel Config:**
    - `CONFIG_VFIO=m`
    - `CONFIG_VFIO_PCI=m`
    - [Enabled IOMMU](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Setting_up_IOMMU)
