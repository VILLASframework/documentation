# FIWARE IoTAgent Ultralight 2.0 Protocol

Ultralight 2.0 is a lightweight text based protocol aimed to constrained devices and communications where the bandwidth and device memory may be limited resources.

It is used by FIWAREs IotAgent-UL. 

## Implementation

The source code of the format-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/lib/formats/iotagent_ul.cpp

## Configuration {#config}

The `iotagent_ul` format-type supports the following settings:

import ApiSchema from '@theme/ApiSchema';

<ApiSchema
  specUrl="external/node/doc/dist.yaml"
  schemaRef="#/components/schemas/iotagent_ul"
/>

## Example Configuration {#example}

@include node/etc/examples/formats/iotagent_ul.conf

## Further Documentation

- https://fiware-iotagent-ul.readthedocs.io/
