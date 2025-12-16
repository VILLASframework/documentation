---
sidebar_position: 4
---

# Network Emulation

VILLASnode supports the emulation of wide-area network characteristics.

This emulation can be configured on a per-node basis for **outgoing** (egress) data only.
Incoming data is not processed by the network emulation!

This network emulation is handled by Linux's [netem queuing discipline](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem), which is part of the traffic control subsystem.
Take a look at the following manual page for supported metrics: [tc-netem(8)](http://man7.org/linux/man-pages/man8/tc-netem.8.html).

VILLASnode only takes care of setting up and initializing the netem queuing discipline inside the kernel.
For this, the iproute2 software package (`ip` & `tc` commands) must be installed.
The configuration is done via the configuration file.
Look at `etc/example.conf` for a section called `netem` or `tc-netem(8)` for more details.

## Fix for Fedora

For some reason, Fedora installs the delay distribution profiles under `/usr/lib64/tc/`,
but libnl3 only searches in `/usr/lib/tc/`. This results in the following error when using netem:

``` # noqa MD040
Invalid delay distribution 'normal' in netem config in
```

To fix this error, please add a symlink: `ln -s /usr/lib64/tc /usr/lib/tc`

## Custom delay distribution

Netem supports loading custom delay distributions.

1. Load and compile the netem tools from:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/netem
2. Create a custom distribution by following the steps described here:
   https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.distribution
3. Put the generated distribution with the suffix `.dist` in the `tc` library directory:  `/usr/lib/tc/`.
4. Load the distribution by specifying the basename in the server configuration.

## Further information

 - https://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/tree/README.iproute2+tc
 - https://codeberg.org/stv0g/netplika

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" pointer="#/components/schemas/netem" />

# Example

``` url="external/node/etc/examples/nodes/netem.conf" title="node/etc/examples/nodes/netem.conf"
nodes = {
    udp_node = {
        type = "socket"

        format = "gtnet"

        in = {
            address = "127.0.0.1:12001"
        }

        out = {
            address = "127.0.0.1:12000"

            # Network emulation settings
            # Those settings can be specified for each node individually!
            netem = {
                enabled = true

                # Additional latency in microseconds
                delay = 100000

                # Jitter in uS
                jitter = 30000

                # Distribution of delay: uniform, normal, pareto, paretonormal
                distribution = "normal"

                # Packet loss in percent
                loss = 10

                # Duplication in percent
                duplicate = 10

                # Corruption in percent
                corrupt = 10
            }
        }
    }
}
```
