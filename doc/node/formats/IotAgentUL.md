# FIWARE IoTAgent Ultralight 2.0 Protocol {#node-format-fiware-iotagent-ul}

Ultralight 2.0 is a lightweight text based protocol aimed to constrained devices and communications where the bandwidth and device memory may be limited resources.

It is used by FIWAREs IotAgent-UL. 

# Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/iotagent_ul.cpp
# Configuration {#node-config-format-iotagent-ul}

The @ref node-format-iotagent-ul format-type supports all [generic format options](@ref node-config-format).

# Example Configuration {#node-format-iotagent-ul-example}

@include node/etc/examples/formats/iotagent_ul.conf

# Further Documentation

* https://fiware-iotagent-ul.readthedocs.io/
