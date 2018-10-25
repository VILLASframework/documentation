# Tuning {#node-tuning}

This page is not directly related to VILLASnode.
It describes several ways to optimize the host system for running real-time applications like VILLASnode.

## Operating System and Kernel

For minimum latency several kernel and driver settings can be optimized.
A [PREEMPT_RT patched Linux](https://rt.wiki.kernel.org/index.php/Main_Page) kernel is recommended.
Precompiled kernels for Fedora can be found here: http://ccrma.stanford.edu/planetccrma/software/

1. Tune overall system performance for real-time:
  1. Install a `PREEMPT_RT` patched Linux kernel.
  2. Use the `tuned` tool for improving general real-time performance.
    - Please adjust the setting `isolated_cpucores` according to your hardware.
    - Enable the following `realtime` tuned profile

```bash
        $ dnf install tuned-profiles-realtime
        $ echo "realtime" > /etc/tuned/active_profile
        $ echo "isolated_cpucores=6-7" >> /etc/tuned/realtime-variables.conf
        $ systemctl enable tuned && systemctl start tuned
```

2. Optimize the [VILLASnode configuration](@ref node-config).
  1. Map NIC IRQs	(see setting @ref node-config-affinity).
  2. Map Tasks (see global  setting @ref node-config-affinity).
  3. Increase priority of server task (nice(2)) (see global setting  @ref node-config-priority).
  4. Increase BSD socket priority (see global setting @ref node-config-priority for  node-type @ref node-type-socket).
3. Configure NIC interrupt coalescence with `ethtool`:
    `ethtool --coalesce eth0 adaptive-rx off adaptive-tx off`
4. Configure NIC kernel driver in `/etc/modprobe.d/e1000e.conf`:

```
# More conservative interrupt throttling for better latency
# https://www.kernel.org/doc/Documentation/networking/e1000e.txt
option e1000e InterruptThrottleRate=
```

## Hardware

This are some proposals for the selection of appropriate server hardware:

- Server-grade CPU: Intel Xeon
  - A multi-core system enables true paralell execution of multiple send / receive paths.

- Server-grade network cards: Intel PRO/1000
  - These allow offloading of UDP checksumming to the hardware
