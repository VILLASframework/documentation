---
sidebar_position: 5
sidebar_label: Node-types
---

# New Node-types

This page describes the necessary steps for adding a new node-type to VILLASnode.
VILLASnode already comes with a lot of existing implementations of node-types which should provide a good starting point.

1. Choose a short and descriptive name for you node-type. E.g `mqtt`, `websocket`, `iec61850-9-2`.
    - The name must only contain lower-case letters and dashes.
    - In this guide we use `my-proto` as an example.

1. Identify required external dependencies & libraries

1. Check for availability of external libraries in [main `CMakeLists.txt`](https://github.com/VILLASframework/node/blob/master/CMakeLists.txt).
    - Do not forget to introduce a new calls to `cmake_dependent_option()` as well as a `add_feature_info()` for your new node-type further down in the CMake file.

1. Copy the example C++ code:
    - Name the files according to the name of your node-type.
    - Replace dashes with underscores.

    ```shell
    cp lib/nodes/example.cpp lib/nodes/my_proto.cpp
    cp include/villas/example.hpp include/villas/my_proto.hpp
    ```

1. Add the new C++ file to the [`lib/nodes/CMakeLists.txt`](https://github.com/VILLASframework/node/blob/master/lib/nodes/CMakeLists.txt) file
    - Make sure it is guarded by the new CMake option introduce in step 2)

1. Implement the new node-type by editing `my_proto.cpp` and `my_proto.cpp`
    - Make sure to register the new node-type in the last lines of `my_proto.cpp`.
    - Adjust the node-type name as well as add a short description.
    - Remove the `NodeFactory::Flags::HIDDEN` flag from the node-type registration.

1. Implement an integration test for your node-type which test its functionality in an end-to-end test:
    ```shell
    cp tests/integration/node-example.sh tests/integration/node-my-proto.sh
    ```

1. Copy the example configuration and adapt it to your node-type
    ```shell
    cp etc/example/nodes/example.conf etc/example/nodes/my_proto.conf
    ```

1. Copy the configuration schema (OpenAPI spec) and adapt it to your node-type:

    ```shell
    cp doc/openapi/components/schemas/config/nodes/example.yaml doc/openapi/components/schemas/config/nodes/my_proto.yaml
    cp doc/openapi/components/schemas/config/nodes/_example.yaml doc/openapi/components/schemas/config/nodes/_my_proto.yaml
    ```

1. Add the configuration schema of your node-type to the list of available nodes in:
    [`doc/openapi/components/schemas/config/node_obj.yaml`](hhttps://github.com/VILLASframework/node/blob/master/doc/openapi/components/schemas/config/node_obj.yaml)

1. Submit [a new pull-request](https://github.com/VILLASframework/node/pulls) with your changes.
    - Check if build finishes successfully
