# Setup

## FPGA

### Bitstreams / Vivado projects

1. vc707_villas_simple
    - PCIe to loopback and RTDS GTFPGA AXI4-Stream Bridge connected to internal SFP cage
    - M00_AXI: Stream Interconnect CTRL
    - M01_AXI: RTDS GTFPGA AXI4-Stream Bridge CTRL
    - M02_AXI: DMA Inteface
    - M00_AXIS: to RTDS GTFPGA AXI4-Stream Bridge
    - M01_AXIS: to DMA
    - M02_AXIS: to stream loopback
    - S00_AXIS: from RTDS GTFPGA AXI4-Stream Bridge
    - S01_AXIS: from stream loopback
    - S02_AXIS: from DMA


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

VILLASfpga requires a recent Linux kernel with version > 4.18.0
```
uname -a
```

### Command Line

VILLASfpga uses the VFIO subsystem to access the FPGA hardware.

VFIO requires an IOMMU.

```
sudo grubby --update-kernel=ALL --args="intel_iommu=on iommu=pt"
sudo reboot
cat /proc/cmdline
```

### Modules

VILLASfpga requires the following kernel modules to be loaded:

- `vfio`
- `vfio_pci`
```
echo "vfio\nvfio_pci" > /etc/modules-load.d/vfio.conf
```

## Run VILLASfpga without Super-User privileges

@todo
