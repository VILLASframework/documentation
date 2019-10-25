# Setup {#fpga-setup}

## FPGA

### Bitstreams

@todo: Create a list of available bitstreams

@todo: Add instructions on how to flash a bitstream.

### Indentify PCIexpress device

@todo: Describe the usage of `lspci`

## Kernel

### Version

VILLASfpga requires a recent Linux kernel with version > 4.x.x

@todo: Find the lowest supported kernel version.

### Command Line

VILLASfpga uses the VFIO subsystem to access the FPGA hardware.

VFIO requires an IOMMU.

@todo: Describe the necessary changes to the bootloader/Grub.

### Modules

VILLASfpga requires the following kernel modules to be loaded:

- `vfio`
- `vfio_pci`

If not

## Run VILLASfpga without Super-User privileges

@todo