# RTDS CBuilder Control System Components {#node-type-cbuilder}

RTDS's Component Builder creates user-defined components including graphical representation, data menus and real-time code.

Simple CBuilder control blocks can be executed in VILLASnode.
Every CBuilder component is represented as a node in the VILLAS concept.

The aforementioned real-time code is written in a dialect of the C programming language.
This enables easy cross-compilation of CBuilder code for VILLASnode.
The user only has to obey to the specifc structure of CBuilder code.

The file `plugins/simple_circuit.c` is an example for this structure.

# Prerequisites {#node-prereq-cbuilder}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-implementation-cbuilder}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/VILLASnode/blob/develop/lib/nodes/cbuilder.c
