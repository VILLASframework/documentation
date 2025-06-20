---
sidebar_position: 3
---

# Installation

VILLASnode can be installed in multiple ways:

- [Precompiled standalone binaries](#standalone)
- [Docker image](https://git.rwth-aachen.de/acs/public/villas/node/container_registry)
- [Kubernetes (Helm chart)](../installation.md)
- [Nix Flake](#nix)
- or [from source](#source)

:::caution Requirements
Please make sure that your system fulfills the [requirements](requirements.md) before proceeding.
:::

## From sources {#source}

VILLASnode can be compiled from source using [CMake](http://cmake.org).
This process has been tested with the following Linux distributions:

- Fedora 42
- Debian 12 (Bookworm)
- Ubuntu 24.04 (Noble Numbat)
- Rocky Linux 9.3

### Prerequisites

VILLASnode currently has the following list of dependencies:

| Package | Version | Purpose | Optional | License |
| --- | --- | --- | --- | --- |
| [CMake](http://cmake.org/) | >= 3.9 | for generating the build-system | required | BSD 3 |
| [fmtlib](https://github.com/fmtlib/fmt) | >= 6.1.2 | for string formatting | required | MIT |
| [libcurl](https://curl.haxx.se/libcurl/) | >= 7.29.0 | for HTTP REST requests by the [NGSI node-type](nodes/ngsi.md) node-type | required | similar to MIT |
| [libjansson](http://www.digip.org/jansson/) | >= 2.7 | JSON parser for [Websocket node-type](nodes/websocket.md) and [NGSI node-type](nodes/ngsi.md) node-types | required | MIT |
| [libuuid](https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git) | >= 2.29 | - | required | BSD |
| [libwebsockets](http://libwebsockets.org) | >= 3.1.0 | for the [Websocket node-type](nodes/websocket.md) | required | MIT |
| [openssl](https://www.openssl.org) | >= 1.0.0 | for cryptographic hashing functions | required | Apache 2 for >=3.0 |
| [spdlog](https://github.com/gabime/spdlog) | >= 1.8.2 | for logging | required | MIT |
| [comedilib](http://comedi.org) | >= 0.11.0 | for the [Comedi node-type](nodes/comedi.md) | optional | LGPL-2.1 |
| [Criterion](https://github.com/Snaipe/Criterion) | >= 2.3.1 | for running the unit tests | optional | MIT |
| [Etherlab](http://etherlab.org) | >= 1.5.2 | for the [Ethercat node-type](nodes/ethercat.md) | optional | __GPL 3__ |
| [Graphviz](https://graphviz.org/) | >= 2.30 | for the visualisation of configuration files | optional | EPL |
| [libconfig](http://www.hyperrealm.com/libconfig/) | >= 1.4.9 | for parsing the configuration file | optional | LGPL-2.1 |
| [libdatachannel](https://libdatachannel.org/) | >= 0.18.4 | for the WebRTC node-type | optional | MPL-2.0 |
| [libibverbs](https://github.com/linux-rdma/rdma-core) | >= 16.2 | for the [Infiniband node-type](nodes/infiniband.md) | optional | BSD |
| [libiec61850](http://libiec61850.com/libiec61850/) | >= 1.3.1 | for the [IEC61850-8-1](nodes/iec61850-8-1.md) and [IEC61850-9-2](nodes/iec61850-9-2.md) node-types | optional | __GPL 3__ |
| [libmodbus](https://libmodbus.org/) | >= 3.1.0 | for the [Modbus](nodes/modbus.md) node-type | optional | LGPL-2.1 |
| [libnanomsg](http://nanomsg.org/) | >= 1.0.0 | for the [Nanomsg node-type](nodes/nanomsg.md) | optional | MIT |
| [libnice](https://libnice.freedesktop.org/) | >= 0.1.16 | for libdatachannel / WebRTC | optional | MPL-1.1 & LGPL-2.1 |
| [libnl3](http://www.infradead.org/~tgr/libnl/) | >= 3.2.27 | for the network communication & emulation support of the [Socket node-type](nodes/socket.md) node-type | optional | LGPL-2.1 |
| [libOpal\{AsyncApi,Core,Utils\}](https://git.rwth-aachen.de/acs/public/villas/libopal) | - | for running VILLASnode as an Asynchronous process inside your RT-LAB model with [OPAL node-type](nodes/opal.md) | optional | ??? |
| [librdmacm](https://github.com/linux-rdma/rdma-core) | >= 16.2 | for the [Infiniband node-type](nodes/infiniband.md) | optional | BSD |
| [libre](http://www.creytiv.com/re.html) | >= 2.9.0 | for the [RTP node-type](nodes/rtp.md) | optional | BSD 3 |
| [libuldaq](https://github.com/mccdaq/uldaq) | >= 1.0.0 | for the [ULDAQ node-type](nodes/uldaq.md) | optional | MIT |
| [libxil](https://github.com/VILLASframework/libxil) | >= 1.0.0 | for the [VILLASfpga node-type](nodes/fpga.md) | optional | MIT |
| [libzmq](http://zeromq.org) | >= 2.2.0 | for the [ZeroMQ node-type](nodes/zeromq.md) | optional | MPL-2.0 |
| [Lua](http://www.lua.org/) | >= 5.1 | for the [Lua hook](hooks/lua.md) | optional | MIT |
| [mosquitto](https://mosquitto.org) | >= 1.4.15 | for the [MQTT node-type](nodes/mqtt.md) | optional | EPL 2 |
| [protobuf-c](https://github.com/protobuf-c/protobuf-c/) | >= 1.1.0 | for the [Protobuf format-type](formats/protobuf.md) | optional | similar to BSD |
| [protobuf](https://github.com/google/protobuf) | >= 2.6.0 | for the [Protobuf format-type](formats/protobuf.md) | optional | similar to BSD |
| [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) | >= 0.8.0 | for the [AMQP node-type](nodes/amqp.md) | optional | MIT |
| [rdkafka](https://github.com/edenhill/librdkafka) | >= 1.5.0 | for the [Kafka node-type](nodes/kafka.md) | optional | BSD |

There are three ways to install these dependencies:

1. You can install most of the dependencies using the package manger of your Linux distribution:

Use the following command to install the dependencies under Debian/Ubuntu-based distributions:

```shell
sudo apt-get install \
    gcc g++ \
    pkg-config make cmake ninja-build \
    protobuf-compiler protobuf-c-compiler \
    autoconf automake libtool \
    texinfo git mercurial curl \
    flex bison xmlto \
    python3-venv \
    clang-format clangd \
    doxygen dia graphviz \
    libcomedi-dev \
    libconfig-dev \
    libcurl4-openssl-dev \
    libfmt-dev \
    libibverbs-dev \
    libjansson-dev \
    liblua5.3-dev \
    libmodbus-dev \
    libmosquitto-dev \
    libnanomsg-dev \
    libnl-3-dev libnl-route-3-dev \
    libprotobuf-c-dev \
    libprotobuf-dev \
    librabbitmq-dev \
    librdkafka-dev \
    librdmacm-dev \
    libre2-dev \
    libspdlog-dev \
    libssl-dev \
    libusb-1.0-0-dev \
    libzmq3-dev \
    uuid-dev \
    libre2-dev \
    libglib2.0-dev \
    libcriterion-dev
```

or the following line for Fedora/Redhat/RockyLinux systems:

```shell
sudo dnf update
sudo dnf install \
    gcc gcc-c++ \
    pkgconfig make cmake ninja-build \
    autoconf automake autogen libtool \
    texinfo git mercurial curl tar \
    flex bison rpmdevtools \
    python3-devel \
    clang-tools-extra \
    doxygen dia graphviz \
    openssl-devel \
    protobuf-devel \
    protobuf-c-devel \
    fmt-devel \
    hiredis-devel \
    jansson-devel \
    libconfig-devel \
    libcurl-devel \
    libibverbs-devel \
    libmodbus-devel \
    libnl3-devel \
    librabbitmq-devel \
    librdkafka-devel \
    librdmacm-devel \
    libre-devel \
    libusb-devel \
    libuuid-devel \
    libwebsockets-devel \
    lua-devel \
    mosquitto-devel \
    nanomsg-devel \
    spdlog-devel \
    zeromq-devel \
    glib2-devel \
    libnice-devel

```

### Downloading from Git

```shell
# Clone the repository into ./VILLASnode
git clone https://github.com/VILLASframework/node.git VILLASnode
cd VILLASnode

# Initialize at least the common submodule for a successful build
git submodule update --init common

# Initialize all submodules for VILLASfpga support
git submodule update --init --recursive
```

### Install unpackaged dependencies from source - `deps.sh`

VILLASnode requires several external libraries which are not packaged by common Linux distributions (see above).
The script found at `packaging/deps.sh` can be used to build and install the dependencies you could not find packaged.

It supports several configuration options specified in environment variables:

- `PREFIX=<DIR>`: The installation target directory. Default: `/usr/local`
- `DEPS_SCAN`: Only list missing dependencies. Default: unset
- `DEPS_INCLUDE`: Only install the specified dependencies. Default: unset
- `DEPS_SKIP`: Skip the specified dependencies. Default: unset
- `DEPS_NONINTERACTIVE`: Do not ask interactively. Default: unset

Here are some example usages:

```shell
# Install in this directory, /usr/local is also the default if unspecified
export PREFIX=/usr/local

# This asks interactively for each dependency which was determined to be missing
bash packaging/deps.sh

# Force noninteractive install in interactive sessions
DEPS_NONINTERACTIVE=1 bash packaging/deps.sh

# List all dependencies which were determined to be missing on your system
DEPS_SCAN=1 bash packaging/deps.sh

# Specify a subset of the packages from DEPS_SCAN
DEPS_INCLUDE='uldaq jansson' bash packaging/deps.sh

# Install all but a subset of packages from DEPS_SCAN
DEPS_SKIP='libre rdkafka' bash packaging/deps.sh
```

## Compile and install

`VILLASnode` uses CMake for the build and install process.

### Simple build

Simply build VILLASnode with all features available for the dependencies installed on your system.

```shell
# Setup the build directory for a release mode build
cmake -S . -B ./build -DCMAKE_BUILD_TYPE=Release

# Build villas node in the build directory
cmake --build ./build

# You can find the villas-node binary at ./build/src
./build/src/villas-node -h
```

### Installation

You can also install the binaries and tools into to your search path after building them.

```shell
# Install the VILLASnode libraries tools and binaries
cmake --build ./build --target install

# Refresh linker cache
sudo ldconfig
```

### Customizing the build

The compilation of villas can be customized for faster compilation, smaller binaries or to fix issues on more exotic systems.
Normal users should probably stick with the defaults.

#### Exclude broken features

:::note NOTE
If the VILLASnode CMake configuration can't cope with your environment. For example if it detects a dependency,
enables the corresponding features but fails to build. You can deactivate many parts of VILLASnode in a rather fine-grained way.
:::

See the the top-level [`CMakeLists.txt`] file for all options.

For instance, every node-type can be excluded separately using a `-DWITH_NODE_<name>=OFF` flag.
If for example the RTP node is breaking your compilation, you can disable it like this:

```shell
cmake -S . -B build -DWITH_NODE_RTP=OFF
```

#### Minimal builds

:::note NOTE
Minimal builds should only be attempted if you know exactly which of VILLASnode's features you will need.
:::

First use the "-DWITH_DEFAULTS=OFF" cmake flag to deactivate all optional features, even if the dependencies are satisfied.
You can then add the features you need back using the options from [`CMakeLists.txt`].

Here is an example VILLASnode configuration with only the "file" node-type and hooks, which can be configured by JSON or libconfig syntax:

```shell
# Disable all default features
FLAGS+=" -DWITH_DEFAULTS=OFF"

# Enable the villas-* binaries from ./src again
FLAGS+=" -DWITH_SRC=ON"

# Enable the villas-* tools from ./tools again
FLAGS+=" -DWITH_TOOLS=ON"

# Enable libconfig configuration syntax
FLAGS+=" -DWITH_CONFIG=ON"

# Enable the file node
FLAGS+=" -DWITH_NODE_FILE=ON"

# Enable hooks support
FLAGS+=" -DWITH_HOOKS=ON"

cmake -S . -B build ${FLAGS}
```

[`CMakeLists.txt`]: https://github.com/VILLASframework/node/blob/master/CMakeLists.txt#L169

#### GPL-less builds

In certain use-cases a build of VILLASnode without any GPL dependencies might be necessary.
This can be achieved by using the `WITHOUT_GPL` CMake option:

```shell
cmake -S . -B build -DWITHOUT_GPL=ON
```

## Single-binary / Standalone Executable {#standalone}

We provide single-binary / standalone executable builds of VILLASnode bundle all depdendencies in a [self-extracting ARX archive](https://en.wikipedia.org/wiki/Self-extracting_archive).
These standalone binaries allow running VILLASnode irrespectively of the underlying Linux distribution or availability of library dependencies.

The installation becomes pretty simple:

```shell
curl -s https://raw.githubusercontent.com/VILLASframework/node/refs/heads/master/tools/villas-install.sh | bash
```

:::note
Due to the self-extracting archive, the initial start of VILLASnode will be slower than usual.
However, subsequent invocations will be quicker due to caching of the extracted contents.
:::

:::caution
The standalone VILLASnode binary is currently only compatible Linux systems running one one of the following architectures:

-  Intel/AMD x86_64
-  ARM v8 Aarch64
::::

## Docker images {#docker}

There exists a set of Docker images for running and developing VILLASnode.
Docker images are available for x86_64/amd64, armhf and arm64 architectures it you can run it also on a Raspberry Pi or other embedded platforms.
We use Alpinelinux-based images to keep the size of the image below 100MB.

With a working Docker daemon, you can run it like this:

```shell
docker run --privileged registry.git.rwth-aachen.de/acs/public/villas/node
```

To start the main daemon, you can pass a configuration file via a volume mount:

```shell
docker run --volume /path/to/my/local.conf:/config.conf --privileged registry.git.rwth-aachen.de/acs/public/villas/node node /config.conf
```

## Nix {#nix}

VILLASnode is also packaged as a [Nix Flake](https://wiki.nixos.org/wiki/Flakes).
[Nix](https://nixos.org) is a cross-platform package manager for Unix-like systems, and a tool to instantiate and manage those systems, invented in 2003 by Eelco Dolstra.

### Setup Nix

Note that flakes are an (as of May 2025) experimental feature of the Nix project to provide the declarative and fully reproducible builds of Nix without the hassle of manually updating hashes.

Using `villas` as a flake thus requires the nix package manager to be installed and the `flakes` and `nix-command` features to be enabled.

Documentation:

- Installation: https://nixos.org/download.html
- Enable Flakes: https://nixos.wiki/wiki/Flakes#Enable_flakes

Try to run `villas node` by typing

```shell
nix run github:VILLASframework/node -- node --help
```

For more details please refer to the details here: https://github.com/VILLASframework/node/blob/master/packaging/nix/README.md

## Test installation {#test}

Verify everything is working and required node-types are compiled-in:

```shell
villas node --help
```

Will print the current version including a list of all supported node-types, hooks, etc.
