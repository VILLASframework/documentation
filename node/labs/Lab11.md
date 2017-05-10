# Lab 11: Multi / De-multiplexing {#node-guide-lab11}

**Note:** This feature is currently under development and not yet available.

@image html villas_node_demux.svg height=300px

In scenarios with more than two simulators which are connected in a star topology, merging / spliting of values originating / targeting from different simulators becomes necessary.
This is implemented in VILLASnode in the concept of (de-)multiplexing.

## Configuration file

@includelineno lab11.conf

## The register modes

@image html register.svg The different register modes. width=60%