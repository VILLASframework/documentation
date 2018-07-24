# Infiniband {#node-type-infiniband}

The @ref node-type-infiniband node-type implements node communication over the [Infiniband standard](http://www.infinibandta.org/content/pages.php?pg=about_us_infiniband).

# Configuration {#node-config-infiniband}

Every `infiniband` node can be configured to only read or write or to do both at the same time. The node configuration is divided into two sub-groups: `in` and `out`.

## rdma_port_space (string: "RDMA_PS_TCP" | "RDMA_PS_UDP") {#node-config-infiniband-port-space}

This specifies the type of connection the node will set up. 

* `RDMA_PS_TCP` provides reliable, connection-oriented, message based communication between the nodes. Packets are delivered in order. In this mode, one Queue Pair is connected to one othere Queue Pair.
* `RDMA_PS_UDP` provides unreliable, connection less, datagram communication between nodes. Both ordering and delivery are not guaranteed in this mode.i

`RDMA_PS_TCP` and `RDMA_PS_UDP` are mapped to the Queue Pair types as `IBV_QPT_RC`, `IBV_QPT_UD`, respectively. If two nodes should be connected, both should be set to the same `rdma_port_space`.

More information on these two modes can be found on the manual page for [`rdma_create_id()`](https://linux.die.net/man/3/rdma_create_id).

**Example**:

```conf
rdma_port_space = "RDMA_PS_TCP"
```

enables the node to establish and accept a reliable, connection-oriented, message based connection with another node.

## in.address (string) {#node-config-infiniband-in.address}

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


## in.max_wrs (int) {#node-config-infiniband-in.max_wrs}

This value sets the maximum number of receive Work Requests which can be posted to the receive queue of the Queue Pair. 

For higher throughputs, it is recommended to increase this value since it will serve as a buffer.

Default value: `128`

## in.cq_size (int) {#node-config-infiniband-in.cq_size}

This value defines the number of Work Completions the Completion Queue can hold. 

If a packet is received, the Queue Pair will write a Work Completion to the Completion Queue. The node polls this queue to process received packets. If the Completion Queue gets full, which is often caused by `cq_size` being to small, and thus the receive queue is not able to post Work Completions, the node will abort.

If a connection is disconnected, all outstanding Work Requests—even is they are not used—are flushed to the Completion Queue. Here applies the same as mentioned above: if the Completion Queue has fewer space left than outstanding Work Requests are available, this will result in an error. 

It is therefor recommended to set the value of `cq_size` to at least `@ref node-config-infiniband-in.max_wrs in.max_wrs - @ref node-config-infiniband-in.buffer_subtraction in.buffer_subtraction`.

Default value: `128`

## in.poll_mode (string: "BUSY" | "EVENT") {#node-config-infiniband-in.poll_mode}

## in.buffer_subtraction (int) {#node-config-infiniband-in.buffer_subtraction}

## Example

```
nodes = {
    ib_node_target = {
    type = "infiniband",

    rdma_port_space = "RDMA_PS_TCP", //RDMA_PS_TCP or RDMA_PS_UDP

   in = {
        address = "10.0.0.1:1337",

        max_wrs = 8192,
        cq_size = 8192,

        vectorize = 1,

        poll_mode = "BUSY", //BUSY or EVENT
        buffer_subtraction = 128,

    },  

    out = {
        address = "10.0.0.2:1337",
        resolution_timeout = 1000,

        max_wrs = 8192,
        cq_size = 256,

        vectorize = 1,

        send_inline = 1,
        max_inline_data = 60,
    }
}  
```