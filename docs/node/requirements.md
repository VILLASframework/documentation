---
sidebar_position: 2
---

# Requirements

This page documents the requirements for running VILLASnode.

## Hardware

We recommend a recent 64-bit Intel x86_64 Xeon server with at least 8 CPU cores in combination with a professional Intel network card providing multiple independent Ethernet ports.
This allows you to optimize VILLAS to run on an isolated set of CPU cores and use a dedicated network port for the simulation data.
Please have a look at the [tuning guide](./tuning.md) for details.

Minimum tested system requirements are:

- **CPU:** Quad-core >= 1Ghz
- **RAM:** 1 GiB
- **Architectures:** x86_64, arm64, armv7
- **Disk:** 10 GiB

VILLASnode has also been tested on various other systems:

- Raspberry Pi 3b+
- Raspberry Pi 4
- Xilinx Petalinux MPSoC Boards
- VirtualBox / QEmu / Parallels Virtual Machines
    - OpenStack Instances
- As Docker container / Kubernetes pod

:::caution
We explicitly advise against using virtualized environments for anything apart from testing and development due to unpredictable latencies and bad real-time performance.
:::

## Operating system

VILLASnode is regularly tested on the following operating systems:

- Fedora 34 (recommended)
- Debian 11.2 - Bullseye
- CentOS / RHEL / RockyLinux 8
- Alpine 3.13
- Ubuntu 20.04

Better real-time performance can be achieved by using an optimized system configuration. Please take a look at the [Tuning](tuning.md) page for details.

:::caution
Disable any firewall on your system or configure it accordingly to work with the protocols used by VILLASnode. An improperly configured firewall is the most common issue reported while using VILLASnode!


E.g. on a RHEL/CentOS/RockyLinux or Fedora system:
```shell
systemctl disable --now firewalld
```
:::
