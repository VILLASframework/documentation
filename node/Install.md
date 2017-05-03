# Installation {#node-installation}

VILLASnode can be installed in multiple ways:

- Using a pre-build Docker image
- Using pre-build RPM packages for Redhat based Linux distributions
- or from source

## Prerequisites

VILLASnode currently has the following list of dependencies:

 - [libconfig](http://www.hyperrealm.com/libconfig/) for parsing the configuration file.
 - [libnl3](http://www.infradead.org/~tgr/libnl/) for the network communication & emulation support of the `socket` node-type.
 - libOpal{AsyncApi,Core,Utils} for running VILLASnode as an Asynchronous process inside your RT-LAB model.
 - [libjansson](http://www.digip.org/jansson/) JSON parser for `websocket` and `ngsi` node-types.
 - [libwebsockets](http://libwebsockets.org) for the `websocket` node-type.
 - [libcurl](https://curl.haxx.se/libcurl/) for HTTP REST requests by the `ngsi` node-type.
 - [openssl]()
 
There are two ways to install these dependencies:

1. You can most of the dependencies using the package manger of your Linux distribution:
 
Use the following command to install the dependencies under Debian-based distributions:

```
$ sudo apt-get install build-essential pkg-config wget tar cmake doxygen dia graphviz libconfig-dev libnl-3-dev libnl-route-3-dev libjansson-dev libcurl4-openssl-dev
```

or the following line for Fedora / CentOS / Redhat systems:

```
$ sudo yum install gcc pkgconfig make wget tar cmake openssl-devel doxygen dia graphviz libconfig-devel libnl3-devel libcurl-devel jansson-devel
```

 2. Alternatively, you can use the build system to download, compile and install all dependencies:
 
```
$ make install-thirdparty
``` 
 
## Downloading VILLASnode

```
$ git clone --recursive git@git.rwth-aachen.de:VILLASframework/VILLASnode.git
$ cd VILLASnode
```

## Compilation

Checkout the `Makefile` and `include/config.h` for some options which have to be specified at compile time.

Afterwards, start the compilation with:

```
$ make
$ make run-tests
```

Append `V=5` to `make` for a more verbose debugging output.
Append `DEBUG=1` to `make` to add debug symbols.

## Installation

Install the files to your search path:

```
$ make install
$ make install-doc
```

Append `PREFIX=/opt/local` to change the installation destination.

## Test

Verify everything is working and required node-types are compiled-in:

```
$ villas node --help
```

Will print the current version including a list of all supported node-types, hooks, etc.