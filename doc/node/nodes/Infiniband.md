# Infiniband {#node-type-infiniband}

The @ref node-type-infiniband node-type implements node communication over the [Infiniband standard](http://www.infinibandta.org/content/pages.php?pg=about_us_infiniband).

# Prerequisites {#node-prereq-infiniband}

This node-type requires [libibverbs](https://github.com/linux-rdma/rdma-core) (>= 16.2) and [librdmacm](https://github.com/linux-rdma/rdma-core) (>= 16.2).

# Implementation {#node-implementation-infiniband}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/infiniband.c

# Configuration {#node-config-node-infiniband}

Every `infiniband` node can be configured to only read or write or to do both at the same time. The node configuration is divided into two sub-groups: `in` and `out`.

## rdma_port_space (string: "RC" | "UC" | "UD") = "RC" {#node-config-node-infiniband-port-space}

This specifies the type of connection the node will set up.

* `RC` provides reliable, connection-oriented, message based communication between the nodes. Packets are delivered in order. In this mode, one Queue Pair is connected to one othere Queue Pair.
* `UC` provides unreliable, connection-oriented, message based communication between the nodes. This service type is not officially supported by the RDMA communication manager and is implemented for scientific purposes in VILLASnode. [The InfiniBand node-type source code provides information on how to enable this service type.](https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/infiniband.c#L429)
* `UD` provides unreliable, connectionless, datagram communication between nodes. Both ordering and delivery are not guaranteed in this mode.

`RC`, `UC`, and `UD` are mapped to the Queue Pair types as `RDMA_PS_TCP`/`IBV_QPT_RC`, `RDMA_PS_IPOIB`/`IBV_QPT_UC`, and `RDMA_PS_UDP`/`IBV_QPT_UD`, respectively. If two nodes should be connected, both should be set to the same `rdma_port_space`.

More information on these two modes can be found on the manual page for [`rdma_create_id()`](https://linux.die.net/man/3/rdma_create_id).

## in.address (string) {#node-config-node-infiniband-in-address}

Connections between @ref node-type-infiniband nodes are established over IP over IB (IPoIP). To use this node, you have to make sure that the linux driver `ib_ipoib` is loaded. If it is not loaded, load it with `modprobe ib_ipoib`.

If it is loaded, you have to make sure that the Host Channel Adapters (HCAs) have an IP address. You can configure the IP address of the Infiniband HCA with the `ifconfig` utility, exactly like you would configure normal Ethernet adapters.

As soon as an IP is set for the local HCA, this entry can be used to point to the adapter and to define the port which will be used for connection related communication.

**Example**:

```conf
in = {
    address="10.0.0.1:1337"
}
```

binds the node to the local device which is bound to `10.0.0.1`. It will use port `1337` for communication related to the connection.

## in.max_wrs (integer) = 128 {#node-config-node-infiniband-in-max_wrs}

Before a packet can be received with Infiniband, the application has to describe how this will be handled (e.g., to what address the data will be written). This happens in a so called Work Request (WR).

`in.max_wrs` sets the maximum number of receive Work Requests which can be posted to the receive queue of the Queue Pair.

For higher throughputs, it is recommended to increase this value since it will serve as a buffer.
The default value of this setting is 128.

## in.cq_size (integer) = 128 {#node-config-node-infiniband-in-cq_size}

This value defines the number of Work Completions the Completion Queue can hold.

If a packet is received, the Queue Pair will write a Work Completion to the Completion Queue. The node polls this queue to process received packets. If the Completion Queue gets full, which is often caused by `cq_size` being to small, and thus the receive queue is not able to post Work Completions, the node will abort.

If a connection is disconnected, all outstanding Work Requests—even is they are not used—are flushed to the Completion Queue. Here applies the same as mentioned above: if the Completion Queue has fewer space left than outstanding Work Requests are available, this will result in an error.

It is therefor recommended to set the value of `cq_size` to at least

```conf
in.cq_size >= in.max_wrs - in.buffer_subtraction
```

## in.buffer_subtraction (integer) = 16 {#node-config-node-infiniband-in-buffer_subtraction}

As mentioned in @ref node-config-node-infiniband-in-max_wrs, Work Requests have to be present in the receive queue, for it to be able to process received data. To take full advantage of the zero-copy capabilities of Infiniband this node-type directly posts addresses from the VILLAS Framework to the receive queue instead of copying all data over after receiving it.

This technique relies on the exchange of addresses. This means that if an array of `in.vectorize` addresses is handed over to the node-type, max `release` <= `in.vectorize` addresses that point to received data can be returned.

Furthermore, if `release` addresses should be returned, `release` addresses from the original array must be posted to the receive queue. To ensure that we can always post at least `in.vectorize` new samples to the receive queue, `in.buffer_subtraction` must always be bigger than `in.vectorize`.

A second factor is performance: if `in.buffer_subtraction` is too small it might take long before the node starts to process data since itt has to fill almost the complete queue first. If `in.buffer_subtraction` is too big, the receive buffer might be too small.

Thus, the maximum number of Work Requests to be present in the receive queue is defined as follows:

```c
max_wrs_posted = in.max_wrs - in.buffer_subtraction
```

## out.address (string) {#node-config-node-infiniband-out-address}

This value defines the IPoIB address of the remote node and is used to establish a connection to the remote host—in case of `RDMA_PS_TCP`—or to get the address handle of the remote host—in case of `RDMA_PS_UDP`.

This is similar to @ref node-config-node-infiniband-in-address.

`out.address` has no default value and if it is not defined the node will be set to listening mode and all `out` configuration will be ignored.

**Example**:

```conf
out = {
    address = "10.0.0.1:1337"
}
```

## out.timeout (integer) = 1000 {#node-config-node-infiniband-out-timeout}

This defines the time in milliseconds [`rdma_resolve_addr()`](https://linux.die.net/man/3/rdma_resolve_addr) waits for the resolution of the destination address to complete.
The default value is 1 second.

## out.max_wrs (integer) = 128 {#node-config-node-infiniband-out-max_wrs}

This is similar to @ref node-config-node-infiniband-in-max_wrs but for the send side of the Queue Pair. In contrast to the receive queue, there is no minimum amount of Work Requests in this queue and it can be filled up completely to `out.max_wrs`.
The default number of work requests is 128.

## out.cq_size (integer) = 128 {#node-config-node-infiniband-out-cq_size}

This is similar to @ref node-config-node-infiniband-in-cq_size.

An important side note for the receive completion queue was that it should be able to hold all Work Requests if the receive queue is flushed. Since no "preparatory" Work Requests are posted to the send queue and and thus all work requests are send out as soon as possible, there is no need for `out.cq_size` to be as big as `out.max_wrs`.
The default size of the completion queue is 128.

## out.send_inline (boolean) = true {#node-config-node-infiniband-out-send_inline}

It is possible that the CPU copies the data to be sent directly to the HCA. Then, the HCA can take the data from it's internal memory as soon as it is ready to send it. This has the advantage that the buffer can be returned immediately to the VILLAS Framework and that it increases performance.
By default inline packets are enabled.

If this flag is set, the @ref node-type-infiniband node-type checks if a sample is small enough to be sent inline, and if this is the case sends it inline.

## out.max_inline_data (integer) = 0 {#node-config-node-infiniband-out-max_inline_data}

This value represents the maximum number of bytes to be send inline. The maximum number of this value depends on the HCA.
The settings defaults to zero. However, many HCAs will automatically adjust it to 60.

*Important note*: The greater this value gets, the smaller @ref node-config-node-infiniband-out-max_wrs can be. If `out.max_inline_data` is too big for the number specified in `out.max_wrs`, the node will return an error that the Queue Pair could not be created. Since this is different for various HCAs, it is not possible for us to give more specified errors.

**Example**:

```conf
out = {
    send_inline = 1,
    max_inline_data = 60
}
```

Every sample which is smaller than 60 bytes will be send inline. All other samples will be sent normally.

## out.use_fallback (boolean) = true {#node-config-node-infiniband-out-use_fallback}

If an out section with a valid remote entry is present in the configuration file, the node will first bind to the local host channel adapter and subsequentely try to connect to the remote host. If the latter fails (e.g., because the remote host was not reachable or rejected the connection), there are two possible outcomes: the node can throw an error and abort or it can show a warning and continue in listening mode.

If `use_fallback = true`, the node will fallback to listening mode if it is not able to connect to the remote host.

## out.periodic_signaling (int) = out.max_wrs / 2 {#node-config-node-infiniband-out-periodic_signaling}
If a sample is sent inline, no Completion Queue Entry (CQE) is generated. However, once a while, a CQE must be generated to prevent the Send Queue from overflowing. Therefore, every `out.periodic_signaling`th sample will be sent normally with signaling.

It turns out that the ideal value in most cases is `out.max_wrs / 2`. Hence, usually, it is not necessary to explicitly set this value.

## Example

@include node/etc/examples/nodes/infiniband.conf


## State diagram

@htmlonly
<div class="mermaid">
stateDiagram-v2
    initialized: <b>initialized</b><br>(from Node)
    parsed: <b>parsed</b><br>(from Node)
    destroyed: <b>destroyed</b><br>(from Node)
    checked: <b>checked</b><br>(from Node)
    stopped: <b>stopped</b><br>(from Node)
    started: <b>started</b><br>(from Node)
    [*] --> initialized
    initialized --> parsed: _init()
    parsed --> destroyed: _destroy()
    parsed --> checked: _check()
    checked --> started: _start()
    started --> connected
    connected --> started
    connected --> stopped
    stopped --> destroyed: _destroy()
    started --> stopped: _stop()
    stopped --> started: _start
    checked --> destroyed: _destroy()
</div>
@endhtmlonly
