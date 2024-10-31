---
hide_table_of_contents: true
---

# OPAL-RT Integration

There are three options to exchange simulation signals with an OPAL-RT real-time simulator:

1. **[UDP Sockets](socket.md):** Use OPAL-RT's UDP/TCP I/O interfaces or an adapted version of the AsyncIP example for asynchronous processes.
    In this mode, OPAL-RT targets will send signals via a UDP socket to VILLASnode.
	VILLASnode use the [`socket` node-type](socket.md) node-type to send and receive these UDP packets.
	More information about our adapted AsyncIP example can be found here: [AsyncIP client](../clients/opal_async_ip.md).

2. **[Orchestra](opal_orchestra.md):** VILLASnode can act as an Orchestra client.
    Orchstra is OPAL-RT's co-simulation framework for integrating custom code and external models.
	The functionality is implemented in the closed-source [`opal.orchestra`](opal_orchestra.md) node-type.

3. **[Asynchronous Process](opal_async.md):** VILLASnode can act as an RT-LAB Asynchronous Process.
    Data exchange is then handled using OPAL-RT's `libOpalAsyncApi`.
    The functionality is implemented in the closed-source [`opal.async`](opal_async.md) node-type.
