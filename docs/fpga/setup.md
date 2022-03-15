# Setup

## FPGA

### Bitstreams

:::note ToDo

Create a list of available bitstreams

:::

:::note ToDo

Add instructions on how to flash a bitstream.

:::

### Indentify PCIexpress device

:::note ToDo

Describe the usage of `lspci`

:::

## Kernel

### Version

VILLASfpga requires a recent Linux kernel with version > 4.x.x

:::note ToDo

Find the lowest supported kernel version.

:::

### Command Line

VILLASfpga uses the VFIO subsystem to access the FPGA hardware.

VFIO requires an IOMMU.

:::note ToDo

Describe the necessary changes to the bootloader/Grub.

:::

### Modules

VILLASfpga requires the following kernel modules to be loaded:

- `vfio`
- `vfio_pci`

## Run VILLASfpga without Super-User privileges

@todo
