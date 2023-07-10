---
sidebar_position: 3
---

# Installation

VILLASnode can be installed in multiple ways:

- [Docker image](https://git.rwth-aachen.de/acs/public/villas/node/container_registry)
- [Kubernetes (Helm chart)](../installation.md)
- [Bootable Linux live image](../liveusb/index.md)
- Automated [Kickstart installation](#kickstart) for Fedora/Redhat based distros
- or from source

:::caution Requirements
Please make sure that your system fulfills the [requirements](requirements.md) before proceeding.
:::

## From source  {#source}

VILLASnode can be compiled from source using [CMake](http://cmake.org).
This process has been tested with the following Linux distributions:

 - Fedora 36
 - Debian 12 (Bookworm)
 - Ubuntu 22.04 (Jammy Jellyfish)
 - RHEL / Rocky Linux 8

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
| [libnanomsg](http://nanomsg.org/) | >= 1.0.0 | for the [Nanomsg node-type](nodes/nanomsg.md) | optional | MIT |
| [libnice](https://libnice.freedesktop.org/) | >= 0.1.16 | for libdatachannel / WebRTC | optional | MPL-1.1 & LGPL-2.1 |
| [libnl3](http://www.infradead.org/~tgr/libnl/) | >= 3.2.27 | for the network communication & emulation support of the [Socket node-type](nodes/socket.md) node-type | optional | LGPL-2.1 |
| [libOpal{AsyncApi,Core,Utils}](https://git.rwth-aachen.de/acs/public/villas/libopal) | - | for running VILLASnode as an Asynchronous process inside your RT-LAB model with [OPAL node-type](nodes/opal.md) | optional | ??? |
| [librdmacm](https://github.com/linux-rdma/rdma-core) | >= 16.2 | for the [Infiniband node-type](nodes/infiniband.md) | optional | BSD |
| [libre](http://www.creytiv.com/re.html) | >= 2.9.0 | for the [RTP node-type](nodes/rtp.md) | optional | BSD 3 |
| [libuldaq](https://github.com/mccdaq/uldaq) | >= 1.0.0 | for the [ULDAQ node-type](nodes/uldaq.md) | optional | MIT
| [libxil](https://github.com/VILLASframework/libxil) | >= 1.0.0 | for the [VILLASfpga node-type](nodes/fpga.md) | optional | MIT |
| [libzmq](http://zeromq.org) | >= 2.2.0 | for the [ZeroMQ node-type](nodes/zeromq.md) | optional | __GPL 3__ |
| [Lua](http://www.lua.org/) | >= 5.1 | for the [Lua hook](hooks/lua.md) | optional | MIT |
| [mosquitto](https://mosquitto.org) | >= 1.4.15 | for the [MQTT node-type](nodes/mqtt.md) | optional | EPL 2 |
| [protobuf-c](https://github.com/protobuf-c/protobuf-c/) | >= 1.1.0 | for the [Protobuf format-type](formats/protobuf.md) | optional | similar to BSD |
| [protobuf](https://github.com/google/protobuf) | >= 2.6.0 | for the [Protobuf format-type](formats/protobuf.md) | optional | similar to BSD |
| [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) | >= 0.8.0 | for the [AMQP node-type](nodes/amqp.md) | optional | MIT |
| [rdkafka](https://github.com/edenhill/librdkafka) | >= 1.5.0 | for the [Kafka node-type](nodes/kafka.md) | optional | BSD |

There are three ways to install these dependencies:

1. You can install most of the dependencies using the package manger of your Linux distribution:

Use the following command to install the dependencies under Debian/Ubuntu-based distributions:

```bash
sudo apt-get install \
    gcc g++ \
    pkg-config make cmake ninja-build \
    protobuf-compiler protobuf-c-compiler \
    autoconf automake libtool \
    texinfo git mercurial curl \
    flex bison xmlto \
    doxygen dia graphviz \
    libssl-dev \
    libprotobuf-dev \
    libprotobuf-c-dev \
    uuid-dev \
    libconfig-dev \
    libnl-3-dev libnl-route-3-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    libzmq3-dev \
    libnanomsg-dev \
    librabbitmq-dev \
    libmosquitto-dev \
    libcomedi-dev \
    libibverbs-dev \
    librdmacm-dev \
    libre2-dev \
    libspdlog-dev \
    libfmt-dev \
    libusb-1.0-0-dev \
    liblua5.3-dev \
    librdkafka-dev
```

or the following line for Fedora/Redhat/RockyLinux systems:

```bash
sudo yum install epel-release
sudo yum install \
    gcc gcc-c++ \
    pkgconfig make cmake ninja-build \
    protobuf-compiler protobuf-c-compiler \
    autoconf automake libtool \
    texinfo git mercurial curl tar \
    flex bison rpmdevtools \
    doxygen dia graphviz \
    openssl-devel \
    protobuf-devel \
    protobuf-c-devel \
    libuuid-devel \
    libconfig-devel \
    libnl3-devel \
    libcurl-devel \
    jansson-devel \
    spdlog-devel \
    fmt-devel \
    libwebsockets-devel \
    zeromq-devel \
    nanomsg-devel \
    librabbitmq-devel \
    mosquitto-devel \
    libibverbs-devel \
    librdmacm-devel \
    libusb-devel \
    lua-devel \
    hiredis-devel \
    libre-devel \
    librdkafka-devel
```

### Downloading from Git

```bash
# clone the repository into ./VILLASnode
git clone https://github.com/VILLASframework/node.git VILLASnode
cd VILLASnode

# initialize at least the common submodule for a successful build
git submodule update --init common

# initialize all submodules for VILLASfpga support
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
```bash
# install in this directory, /usr/local is also the default if unspecified
export PREFIX=/usr/local

# this asks interactively for each dependency which was determined to be missing
bash packaging/deps.sh

# force noninteractive install in interactive sessions
DEPS_NONINTERACTIVE=1 bash packaging/deps.sh

# list all dependencies which were determined to be missing on your system
DEPS_SCAN=1 bash packaging/deps.sh

# specify a subset of the packages from DEPS_SCAN
DEPS_INCLUDE='uldaq jansson' bash packaging/deps.sh

# install all but a subset of packages from DEPS_SCAN
DEPS_SKIP='libre rdkafka' bash packaging/deps.sh
```

## Compile and install

`VILLASnode` uses CMake for the build and install process.

### Simple build

Simply build VILLASnode with all features available for the dependencies installed on your system.

```bash
# setup the build directory for a release mode build
cmake -S . -B ./build -DCMAKE_BUILD_TYPE=Release

# build villas node in the build directory
cmake --build ./build

# you can find the villas-node binary at ./build/src
./build/src/villas-node -h
```

### Installation

You can also install the binaries and tools into to your search path after building them.

```bash
# install the VILLASnode libraries tools and binaries
cmake --build ./build --target install
```

### Customizing the build

The compilation of villas can be customized for faster compilation, smaller binaries or to fix issues on more excotic systems.
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
# disable all default features
FLAGS+=" -DWITH_DEFAULTS=OFF"

# enable the villas-* binaries from ./src again
FLAGS+=" -DWITH_SRC=ON"

# enable the villas-* tools from ./tools again
FLAGS+=" -DWITH_TOOLS=ON"

# enable libconfig configuration syntax
FLAGS+=" -DWITH_CONFIG=ON"

# enable the file node
FLAGS+=" -DWITH_NODE_FILE=ON"

# enable hooks support
FLAGS+=" -DWITH_HOOKS=ON"

cmake -S . -B build $FLAGS
```

[`CMakeLists.txt`]: https://github.com/VILLASframework/node/blob/master/CMakeLists.txt#L169

## Docker images {#docker}

There exists a set of Docker images for running and developing VILLASnode.
Docker images are available for x86_64/amd64, armhf and arm64 architectures it you can run it also on a Raspberry Pi or other embedded platforms.
We use Alpinelinux-based images to keep the size of the image below 100MB.

With a working Docker daemon, you can run it like this:

```bash
docker run --privileged registry.git.rwth-aachen.de/acs/public/villas/node
```

To start the main daemon, you can pass a configuration file via a volume mount:

```bash
docker run --volume /path/to/my/local.conf:/config.conf --privileged registry.git.rwth-aachen.de/acs/public/villas/node node /config.conf
```

## Kickstart installation

[Kickstart](https://docs.fedoraproject.org/en-US/fedora/f35/install-guide/advanced/Kickstart_Installations/) is a method for automating the installation of Fedora/Redhat based Linux distributions.
It works by using a Kickstart (`.ks`) file which contains a configuration of all the installation options which the user would usually manually enter using the installation wizard.

We have prepared such a Kickstart file which installs Fedora with our recommended configuration as well as [installs VILLASnode from source](#source) as described above.

To use it, you will need to download a [Netinstall image of Fedora Server](https://getfedora.org/de/server/download/) and copy it to a USB stick or opticial disk.
You also need to interrupt the initial boot of the Fedora installer, in the boot manager and append the following Kernel command line:

```
inst.ks=https://raw.githubusercontent.com/VILLASframework/node/master/packaging/live-iso/villas.ks
```

Further details on how to start the Kickstart installation can be found [in the official Fedora documentation](https://docs.fedoraproject.org/en-US/fedora/f35/install-guide/advanced/Kickstart_Installations/#sect-kickstart-installation-starting).

## Test installation {#test}

Verify everything is working and required node-types are compiled-in:

```bash
villas node --help
```

Will print the current version including a list of all supported node-types, hooks, etc.

