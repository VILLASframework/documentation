# Lab 11: Multi / Demultiplexing {#node-guide-lab11}

@image html villas_node_demux.svg height=300px

In scenarios with more than two simulators which are connected in a star topology, merging / splitting of values originating / targeting from different simulators becomes necessary.
This is implemented in VILLASnode in the concept of (de-)multiplexing.

The following configuration settings in a path definition are relavant and described in this lab session.

 - @ref node-config-path-mode
 - @ref node-config-path-mask
 - @ref node-config-path-rate

## Multiplexing

Multiplexing describes the process of merging signals from multiple input nodes into a single sample which then is processed futher in its entirety.

In this lab session, we multiplex signals originating from nodes `rtds_gtnet_1` and `rtds_gtnet_2` into a single path.

VILLASnode supports multiplexing by using __mapping__ expressions in the @ref node-config-path-in setting of a path.
We can construct samples by joining joining multiple mapping expressions as seen in the configuration file below.

VILLASnode paths support two major operating mode which can be selected using the @ref node-config-path-mode setting.

- `mode = "all"` causes the path to be triggered, and subsequantially emitting samples to its outputs, once all of the masked input nodes receive new data. This mode behaves like a barrier which is opened once we received an update from all masked inputs. This mode effectivly reduces the number of samples which we sent to the destination nodes/
- `mode = "any"` causes the path to be triggered anytime one of the masked inputs receive new data. In this mode each sample received from any of the inputs triggers new samples to be sent to all destinations.

The @ref node-config-path-mask settings allows the user to limit the effect of the @ref node-config-path-mode setting to certain input nodes. By default the path mask includes all input nodes of a path.

## Demultiplexing

Demultiplexing describes the process of selecting a set of signals from a sample to create a new sample.
VILLASnode supports demultiplexing by using __mapping__ expressions in the @ref node-config-path-in setting of a path.

## Configuration file

@includelineno node/etc/labs/lab11.conf

## The register modes

@image html register.svg The different register modes. width=60%
