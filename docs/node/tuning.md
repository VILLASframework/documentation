---
sidebar_position: 5
---

# Tuning {#node-tuning}

This page is not directly related to VILLASnode.
It describes several ways to optimize the host system for running real-time applications like VILLASnode.


## Hardware

Please have a look at the [requirements page](./requirements.md) for some recommended hardware selection.

## Operating System and Kernel

For minimum latency several kernel and driver settings can be optimized.
A [PREEMPT_RT patched Linux](https://rt.wiki.kernel.org/index.php/Main_Page) kernel is recommended.
Pre-compiled kernels for Fedora can be found here: http://ccrma.stanford.edu/planetccrma/software/

1. Tune overall system performance for real-time:
  1. Install a `PREEMPT_RT` patched Linux kernel.
  2. Use the `tuned` tool for improving general real-time performance.
  - Please adjust the setting `isolated_cpucores` according to your hardware.
  - Enable the following `realtime` tuned profile

```shell
dnf install tuned-profiles-realtime
echo "realtime" > /etc/tuned/active_profile
echo "isolated_cpucores=6-7" >> /etc/tuned/realtime-variables.conf
systemctl enable tuned && systemctl start tuned
```

2. Optimize the [VILLASnode configuration](config/index.md).
  1. Map NIC IRQs	(see global [affinity setting](config/global.md)).
  2. Map Tasks (see global [affinity setting](config/global.md)).
  3. Increase priority of server task (nice(2)) (see global [priority setting](config/global.md)).
  4. Increase BSD socket priority (see global [priority setting](config/global.md) for the [Socket node-type](nodes/socket.md)).
3. Configure NIC interrupt coalescence with `ethtool`:
    `ethtool --coalesce eth0 adaptive-rx off adaptive-tx off`
4. Configure NIC kernel driver in `/etc/modprobe.d/e1000e.conf`:

```
# More conservative interrupt throttling for better latency
# https://www.kernel.org/doc/Documentation/networking/e1000e.txt
option e1000e InterruptThrottleRate=
```

## Real-time

In general we recommend to run VILLASnode with super-user privileges (`sudo villas-node`) as it grants VILLASnode the permission to tweak several system settings for real-time execution.

When VILLASnode is executed in a Docker container, please use the following command line:

```shell
docker run -cpu-rt-period=1000000 --cpu-rt-runtime=800000 --ulimit rtprio=99 --cap-add sys_nice --privileged registry.git.rwth-aachen.de/acs/public/villas/node node
```
