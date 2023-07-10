# Setup

## Install Xilinx FPGA evaluation board


### Identify PCIe device

Identify the bus/device/function (BDF) identifier of the Xilinx Evaluation board:

In the following example the BDF of the Xilinx evaluation board is `88:00.0 `:

```shell
lspci | grep Xilinx
88:00.0 Memory controller: Xilinx Corporation Device 7021
```

Please remember the BDF as it is required for the VILLASfpga configuration later.

## Kernel

### Version

VILLASfpga requires a recent Linux kernel with version > 4.18.0

```shell
uname -a
```

### Command Line

VILLASfpga uses the VFIO subsystem to access the FPGA hardware.

VFIO requires an IOMMU:

- [Enable IOMMU](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Setting_up_IOMMU)

```shell
sudo grubby --update-kernel=ALL --args="intel_iommu=on iommu=pt"
sudo reboot
cat /proc/cmdline
```

### Modules

VILLASfpga requires the following kernel modules to be loaded:

- `vfio`
- `vfio_pci`

```shell
echo "vfio\nvfio_pci" > /etc/modules-load.d/vfio.conf
```

### FPGA Detection

1. Flash FPGA bitstream
2. `echo 1  | sudo tee /sys/bus/pci/rescan`
