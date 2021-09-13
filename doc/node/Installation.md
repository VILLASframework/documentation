# Installation {#node-installation}

VILLASnode can be installed in multiple ways:

- [Docker image](https://git.rwth-aachen.de/acs/public/villas/node/container_registry)
- [Kubernetes (Helm chart)](@ref installation)
- RPM packages for Redhat based Linux distributions
- [Bootable Linux live image](@ref liveusb)
- or from source

# Docker images {#node-installation-docker}

There exists a set of Docker images for running and developing VILLASnode.
Docker images are available for x86_64/amd64, armhf and arm64 architectures it you can run it also on a Raspberry Pi or other embedded platforms.
We use Alpinelinux-based images to keep the size of the image below 100MB.

With a working Docker daemon, you can run it like this:

```bash
$ docker run --privileged registry.git.rwth-aachen.de/acs/public/villas/node
```

To start the main daemon, you can pass a configuration file via a volume mount:

```bash
$ docker run --volume /path/to/my/local.conf:/config.conf --privileged registry.git.rwth-aachen.de/acs/public/villas/node node /config.conf
```

# From source  {#node-installation-source}

VILLASnode can be compiled from source using [CMake](http://cmake.org).
This process has been tested with the following Linux distributions:

 - Fedora 33
 - Debian 10 (Buster)
 - Ubuntu 20.04 (Bionic Beaver)
 - Centos 8
 - Alpine Edge

## Prerequisites

VILLASnode currently has the following list of dependencies:

 - [CMake](http://cmake.org/) (>= 3.9) for generating the build-system (_required_).

 - [libwebsockets](http://libwebsockets.org) (>= 2.3.0) for the @ref node-type-websocket node-type (_required_).
 - [libjansson](http://www.digip.org/jansson/) (>= 2.7) JSON parser for @ref node-type-websocket and @ref node-type-ngsi node-types (_required_).
 - [openssl](https://www.openssl.org) (>= 1.0.0) for cryptographic hashing functions (_required_).
 - [libcurl](https://curl.haxx.se/libcurl/) (>= 7.29.0) for HTTP REST requests by the @ref node-type-ngsi node-type (_required_).
 - [spdlog](https://github.com/gabime/spdlog) (>= 1.8.2) for logging (_required_).
 - [fmtlib](https://github.com/fmtlib/fmt) (>= 6.1.2) for string formatting (_required_).

 - [libconfig](http://www.hyperrealm.com/libconfig/) (>= 1.4.9) for parsing the configuration file (_optional_).
 - [libnl3](http://www.infradead.org/~tgr/libnl/) (>= 3.2.27) for the network communication & emulation support of the @ref node-type-socket node-type (_optional_).
 - [libzmq](http://zeromq.org) (>= 2.2.0) for the @ref node-type-zeromq node-type (_optional_).
 - [libnanomsg](http://nanomsg.org/) (>= 1.0.0) for the @ref node-type-nanomsg node-type (_optional_).
 - [libiec61850](http://libiec61850.com/libiec61850/) (>= 1.3.1) for the @ref node-type-iec61850-8-1 and @ref node-type-iec61850-9-2 node-types (_optional_).
 - [protobuf](https://github.com/google/protobuf) (>= 2.6.0) and [protobuf-c](https://github.com/protobuf-c/protobuf-c/) (>= 1.1.0) for the Protobuf @ref node-format-types (_optional_).
 - [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) (>= 0.8.0) for the @ref node-type-amqp node-type (_optional_).
 - [mosquitto](https://mosquitto.org) (>= 1.4.15) for the @ref node-type-mqtt node-type (_optional_).
 - [comedilib](http://comedi.org) (>= 0.11.0) for the @ref node-type-comedi node-type (_optional_).
 - [libuldaq](https://github.com/mccdaq/uldaq) (>= 1.0.0) for the @ref node-type-uldaq node-type (_optional_)
 - [libre](http://www.creytiv.com/re.html) (>= 0.5.6) for the @ref node-type-rtp node-type (_optional_)
 - [libibverbs](https://github.com/linux-rdma/rdma-core) (>= 16.2) and [librdmacm](https://github.com/linux-rdma/rdma-core) (>= 16.2) for the @ref node-type-infiniband node-type (_optional_)
 - [libOpal{AsyncApi,Core,Utils}](https://git.rwth-aachen.de/acs/public/villas/libopal) for running VILLASnode as an Asynchronous process inside your RT-LAB model with @ref node-type-opal node-type (_optional_).
 - [Etherlab](http://etherlab.org) (>= 1.5.2) for the @ref node-type-ethercat node-type (_optional_)
 - [Criterion](https://github.com/Snaipe/Criterion) (>= 2.3.1) for running the unit tests (_optional_).
 - [libuuid](https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git) (>= 2.29).
 - [libxil](https://git.rwth-aachen.de/acs/public/villas/fpga/libxil) (>= 1.0.0) for the @ref node-type-fpga node-type (_optional_).
 - [Lua](http://www.lua.org/) (>= 5.1) for the @ref node-hook-type-lua hook (_optional_).
 - [rdkafka](https://github.com/edenhill/librdkafka) (>= 1.5.0) for the @ref node-type-kafka node-type (_optional_)
 - [Graphviz](https://graphviz.org/) (>= 2.30) for the visualisation of configuration files (_optional_).

There are three ways to install these dependencies:

1. You can install most of the dependencies using the package manger of your Linux distribution:

Use the following command to install the dependencies under Debian/Ubuntu-based distributions:

```bash
$ sudo apt-get install \
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
    libre-dev \
    libspdlog-dev \
    libfmt-dev \
    libusb-1.0-0-dev \
    liblua5.3-dev \
    librdkafka-dev
```

or the following line for Fedora/CentOS/Redhat systems:

```bash
$ sudo dnf config-manager --add-repo https://packages.fein-aachen.org/fedora/fein.repo
$ sudo dnf install \
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
    libiec61850 \
    librabbitmq-devel \
    mosquitto-devel \
    comedilib-devel \
    libibverbs-devel \
    librdmacm-devel \
    re-devel \
    uldaq-devel \
    libusb-devel \
    lua-devel \
    librdkafka-devel
```

or for Alpine:

```bash
$ echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
$ apk update
$ apk add gcc g++ \
    pkgconf cmake make \
    autoconf automake libtool \
    git mercurial \
    flex bison \
    protobuf \
    file
    openssl-dev \
    ossp-uuid-dev@testing \
    libconfig-dev \
    libwebsockets-dev \
    curl-dev \
    jansson-dev \
    spdlog-dev \
    fmt-dev \
    libnl3-dev \
    graphviz-dev \
    protobuf-dev \
    protobuf-c-dev \
    zeromq-dev \
    nanomsg-dev@testing \
    rabbitmq-c-dev \
    mosquitto-dev \
    libusb-dev \
    lua-dev \
    librdkafka-dev
```

## Downloading from Git

```bash
$ git clone https://git.rwth-aachen.de/acs/public/villas/node.git VILLASnode
$ cd VILLASnode
$ git submodule update --init common
```

## Install unpackaged dependencies

VILLASnode requires several external libraries which are not packaged by common Linux distributions (see above).
Please consult the list above to install at least the mandatory dependencies by hand or use the following script:

```bash
$ bash packaging/deps.sh
```

## Compilation

Start the compilation with:

```bash
$ mkdir build
$ cd build
$ cmake ..
$ make -j$(nproc)
```

## Installation

Install the files to your search path:

```bash
$ sudo make install
$ sudo ldconfig
```

Append `PREFIX=/opt/local` to change the installation destination.

# Test installation {#node-installation-test}

Verify everything is working and required node-types are compiled-in:

```bash
$ villas node --help
```

Will print the current version including a list of all supported node-types, hooks, etc.

