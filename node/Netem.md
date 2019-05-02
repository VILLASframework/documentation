# Network Emulation {#node-netem}

VILLASnode supports the emulation of wide-area network characterisics.

This emulation can be configured on a per-node basis for **outgoing** (egress) data only.
Incoming data is not processed by the network emulation!

This network emulation is handled by Linux' [netem queuing discipline](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem) which is part of the traffic control subsystem.
Take a look at the following manual page for supported metrics: [tc-netem(8)](http://man7.org/linux/man-pages/man8/tc-netem.8.html).

VILLASnode only takes care of setup and initalizing the netem queuing discipline inside the kernel.
For this the iproute2 software package (`ip` & `tc` commands) must be installed.
The configuration is done via the config file.
Look at `etc/example.conf` for a section called `netem` or `tc-netem(8)` for more details.

## Fix for Fedora

For some reason, Fedora installs the delay distribution profiles under `/usr/lib64/tc/`.
But libnl3 only seraches `/usr/lib/tc/`. This results in the following error when using netem:

```
Invalid delay distribution 'normal' in netem config in
```

To fix this error please add a symlink: `ln -s /usr/lib64/tc /usr/lib/tc`

## Custom delay distribution

Netem supports loading custom delay distributions.

1. Load and compile the netem tools from:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/netem
2. Create a custom distribution by following the steps described here:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.distribution
3. Put the generated distrubtion with the suffix `.dist` in the `tc` lib directory:  `/usr/lib/tc/`.
4. Load the distribution specifying the basename in the server config.

## Further information

 - https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.iproute2+tc
 - https://github.com/stv0g/netem

## Configuration {#node-config-netem}

### out.netem.enabled (boolean) = true {#node-config-netem-enabled}

Weather or not network emulation is active.

### out.netem.delay (integer) {#node-config-netem-delay}

Additional latency in micro seconds.

### out.netem.jitter (integer) {#node-config-netem-jitter}

Packet delay jitter in micro seconds.

### out.netem.distribution (string: "normal" | "uniform" | "pareto" | "paretonormal") {#node-config-netem-distribution}

Distribution of delay: uniform, normal, pareto, paretonormal

### out.netem.loss (integer) {#node-config-netem-loss}

Packet loss in percent.

### out.netem.duplicate (integer) {#node-config-netem-duplicate}

Packet duplication in percent.

### out.netem.corrupt (integer) {#node-config-netem-corrupt}

Packet corruption in percent.

# Example
@include node/nodes/netem.conf
