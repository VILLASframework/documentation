---
hide_table_of_contents: true
---

# OPAL-RT Integration <img align="right" width="250px" src="/img/logos/opal-rt.svg" alt="OPAL-RT logo"></img>

There are three options to exchange simulation signals with an OPAL-RT real-time simulator:

1. **[Orchestra](opal_orchestra.md):** VILLASnode can act as an [Orchestra client](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/505348099/Orchestra+I+O).
    Orchestra is OPAL-RT's co-simulation framework for integrating custom code and external models.
	
    The functionality is implemented by the [`opal.orchestra`](opal_orchestra.md) node-type.

    :::tip
    This node-type is recommended for new setups.
    :::

2. **[UDP Sockets](../socket.md):** Use OPAL-RT's [UDP/TCP I/O interfaces](https://opal-rt.atlassian.net/wiki/spaces/PCPM/pages/143720599/TCP+UDP).
    In this mode, OPAL-RT targets will send signals via a UDP socket to VILLASnode.
	More information about our adapted AsyncIP example can be found here: [AsyncIP client](../../clients/opal_async_ip.md).

    This functionality is implemented by the [`socket`](../socket.md) node-type.
	
    :::caution
    This node-type is not recommended due to limited synchronizations, and limitations in I/O signal management.
    :::

3. **[Asynchronous Process](opal_async.md):** VILLASnode can act as an [RT-LAB Asynchronous Process](https://opal-rt.atlassian.net/wiki/spaces/PRD/pages/144020065/Asynchronous+Processes).
    Data exchange is then handled using OPAL-RT's `libOpalAsyncApi`.
    
    The functionality is implemented by the [`opal.async`](opal_async.md) node-type.

    :::danger Deprecation
    This node-type is deprecated and not recommended for new setups.
    :::