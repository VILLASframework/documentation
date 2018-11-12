# Installation {#node-installation}

VILLASnode can be installed in multiple ways:

- Using a pre-build Docker image
- Using pre-build RPM packages for Redhat based Linux distributions
- Using a bootable Linux live image
- or from source

# Bootable Linux live image  {#node-installation-live}

See: @ref liveusb

# From RPM packages {#node-installation-rpm}

We offer pre-build RPM packages for Fedora / Redhat based distributions.

**Note:** These packages have only been tested with Fedora 29. Other distributions or version might work as well but might have unresolvable dependencies.

## With internet access by using VILLAS RPM repository {#node-installation-rpm-offline}

Add VILLAS RPM repository to your system:

```
$ sudo dnf config-manager --add-repo https://packages.fein-aachen.org/fedora/fein.repo
Adding repo from: https://packages.fein-aachen.org/fedora/fein.repo
```

Install VILLASnode plus its dependencies:

```
$ sudo dnf install villas-node
```

```
Last metadata expiration check: 0:02:48 ago on Wed May  3 15:41:29 2017.
Dependencies resolved.
====================================================================================
 Package              Arch   Version                                  Repository
                                                                               Size
====================================================================================
Installing:
 libwebsockets        x86_64 2.2.0-1.fc25                             villas  2.8 M
 libxil               x86_64 0.1-1.fc25                               villas   31 k
 villas-node          x86_64 0.2-1.develop_release.20170427git9b1e6a3.fc25
                                                                      villas  929 k

Transaction Summary
====================================================================================
Install  3 Packages

Total download size: 4 M
Installed size: 15 M
Is this ok [y/N]:

...
```

## Without internet access {#node-installation-rpm-online}

If the Linux host has no internet access, RPM files must be transferred manually to the machine by using a flash drive.

1. Download the latest .rpm files from: https://packages.fein-aachen.org/redhat/x86_64/
2. Copy all files to a flash drive.
3. Mount the flash drive on the Linux host: `$ mount /dev/sdXn /mnt`
    (Replace `sdXn` by using `lsblk` to get the correct device name)
4. Install the .rpm files from the flash drive: `$ rpm -ivh /mnt/*.rpm`
5. Unmount the flash drive: `$ umount /mnt`

## With SSH proxy {#node-installation-rpm-rpxy}

Sometimes only SSH connections are possible from the laboratory networks.
In this case we can use `ssh` to connect to an external machine which will be used as a proxy.

**Note:** The external machine requires access to the internet.

1. Create a SSH SOCKS proxy by connecting to a machine which can reach the internet:
   `$ ssh -fND 12345 user@external-machine`
2. Configure `dnf` [to use the proxy](https://www.cyberciti.biz/faq/how-to-use-dnf-command-with-a-proxy-server-on-fedora/) by adding the following line to `[main]` section of configuration file  `/etc/dnf/dnf.conf`:
   `proxy=socks5h://localhost:12345`
3. Update the dnf package chache and install updates:
   `$ dnf --refresh update`

## Get the currently installed version

```
$ rpm -q villas-node
villas-node-0.3-1.develop_release.20170507gite92f17d.fc25.x86_64
```

# From source  {#node-installation-source}

VILLASnode can be compiled from source using [CMake](http://cmake.org).
This process has been tested with the following Linux distributions:

 - Fedora 29
 - Debian 9 (Stretch)
 - Ubuntu 18.04 (Bionic Beaver)
 - Centos 7

## Prerequisites

VILLASnode currently has the following list of dependencies:

 - [libwebsockets](http://libwebsockets.org) (>= 2.3.0) for the @ref node-type-websocket node-type (_required_).
 - [libjansson](http://www.digip.org/jansson/) (>= 2.7) JSON parser for @ref node-type-websocket and @ref node-type-ngsi node-types (_required_).
 - [openssl](https://www.openssl.org) (>= 1.0.0) for cryptographic hashing functions (_required_).
 - [libcurl](https://curl.haxx.se/libcurl/) (>= 7.29.0) for HTTP REST requests by the @ref node-type-ngsi node-type (_required_).
 
 - [libconfig](http://www.hyperrealm.com/libconfig/) (>= 1.4.9) for parsing the configuration file (_optional_).
 - [libnl3](http://www.infradead.org/~tgr/libnl/) (>= 3.2.27) for the network communication & emulation support of the @ref node-type-socket node-type (_optional_).
 - [libzmq](http://zeromq.org) (>= 2.2.0) for the @ref node-type-zeromq node-type (_optional_).
 - [libnanomsg](http://nanomsg.org/) (>= 1.0.0) for the @ref node-type-nanomsg node-type (_optional_).
 - [libiec61850](http://libiec61850.com/libiec61850/) (>= 1.2.0) for the @ref node-type-iec61850-8-1 and @ref node-type-iec61850-9-2 node-types (_optional_).
 - [protobuf](https://github.com/google/protobuf) (>= 2.6.0) and [protobuf-c](https://github.com/protobuf-c/protobuf-c/) (>= 1.1.0) for the Protobuf @ref node-formats (_optional_).
 - [rabbitmq-c](https://github.com/alanxz/rabbitmq-c) (>= 0.8.0) for the @ref node-type-amqp node-type (_optional_).
 - [mosquitto](https://mosquitto.org) (>= 1.4.15) for the @ref node-type-mqtt node-type (_optional_).
 - [comedilib](http://comedi.org) (>= 0.11.0) for the @ref node-type-comedi node-type (_optional_).
 - [libuldaq](https://github.com/mccdaq/uldaq) (>= 1.0.0) for the @ref node-type-uldaq node-tyle (_optional_)
 - [libOpal{AsyncApi,Core,Utils}](https://git.rwth-aachen.de/acs/public/villas/libopal) for running VILLASnode as an Asynchronous process inside your RT-LAB model (_optional_).
 - [Etherlab](http://etherlab.org) (>= 1.5.2) for the @ref node-type-ethercat node-type (_optional_)
 - [Criterion](https://github.com/Snaipe/Criterion) (>= 2.3.1) for running the unit tests (_optional_).

There are three ways to install these dependencies:

1. You can install most of the dependencies using the package manger of your Linux distribution:

Use the following command to install the dependencies under Debian-based distributions:

```
$ sudo apt-get install \
    gcc g++ \
    pkg-config make cmake ninja-build \
    texinfo git curl \
    doxygen dia graphviz \
    libssl-dev \
    libconfig-dev \
    libnl-3-dev libnl-route-3-dev \
    libjansson-dev \
    libcurl4-openssl-dev \
    libzmq3-dev \
    libnanomsg-dev
    libprotobuf-dev \
    libprotobuf-c-dev \
    librabbitmq-dev \
    libmosquitto-dev \
    libcomedi-dev
```

or the following line for Fedora / CentOS / Redhat systems:

```
$ sudo dnf install \
    gcc gcc-c++ \
    pkgconfig make cmake ninja-build \
    texinfo git curl tar \
    doxygen dia graphviz \
    openssl-devel \
    libconfig-devel \
    libnl3-devel \
    jansson-devel \
    libcurl-devel \
    zeromq-devel \
    nanomsg-devel \
    protobuf-devel \
    protobuf-c-devel \
    librabbitmq-devel \
    mosquitto-devel \
    libiec61850
```

 2. We offer Dockerfiles for different distributions. These files show you how to setup you own development environment.

 - Fedora: `Dockerfile.dev`
 - Centos: `Dockerfile.dev-centos`
 - Debian / Ubuntu: `Dockerfile.dev-ubuntu`

For convinience simple make targets are availble:

- `cmake .. && make docker`: Build Fedora-based Docker image with VILLASnode installed
- `cmake .. && make run-docker-dev`: Start Docker container with Fedora development environment
- `cmake .. && make run-docker-dev-centos`: Start Docker container with CentOS development environment
- `cmake .. && make run-docker-dev-ubuntu`: Start Docker container with CentOS development environment

## Downloading from Git

```
$ git -c submodule."thirdparty/libopal".update=none clone --recursive https://git.rwth-aachen.de/acs/public/villas/VILLASnode.git
$ cd VILLASnode
```

**Note:** The libopal submodule contains software from OPAL-RT which we can not release. Therefore we do not try to clone it by default. Please contact [Steffen Vogel](mailto:svogel2@eonerc.rwth-aachen.de) to get access.

## Compilation

Start the compilation with:

```
$ mkdir build
$ cd build
$ cmake ..
$ make
$ make doc
$ make run-tests
```

## Installation

Install the files to your search path:

```
$ make install
```

Append `PREFIX=/opt/local` to change the installation destination.

# Docker image  {#node-installation-docker}

For first tests and development you can use the Docker platform to bootstrap your environment.
Docker is a software to run containers (a.k.a images in Docker's terminology) on a Linux machine.
We use for development as well as for testing or demonstrating VILLASnode's functionality.

**Note:** We do not recommend to use Docker for running VILLASnode in a real-time simulation.

We prepared a image which you can download and run out of the box:

1. Download the Docker toolbox: https://www.docker.com/docker-toolbox.
    This toolbox includes a virtual machine as well all the Docker tools you need to the Docker container which is provided by us.
     More instructions to get with can be found here: http://docs.docker.com/windows/started/

    ![Download Docker Tollbox](docker_toolbox_download.png)

2. Install the Docker Toolbox by following the instructions of the installer:

    ![Install Docker Toolbox 1](docker_toolbox_installer_1.png)
    ![Install Docker Toolbox 2](docker_toolbox_installer_2.png)
    ![Install Docker Toolbox 3](docker_toolbox_installer_3.png)
    ![Install Docker Toolbox 4](docker_toolbox_installer_4.png)
    ![Install Docker Toolbox 4 - On Windows 10 make sure to install VB with NDIS5 driver](docker_toolbox_installer_4_Win10.png)
    ![Install Docker Toolbox 5](docker_toolbox_installer_5.png)
    ![Install Docker Toolbox 6](docker_toolbox_installer_6.png)
    ![Install Docker Toolbox 7](docker_toolbox_installer_7.png)

3. After the installation finished, open the "Docker Quickstart Terminal".
    During the first startup, Docker will provision a VirtualBox VM to run the VILLASnode Docker image:

   ![Provision of Docker Machine during first startup.](docker_machine_provisioning.png)

4. One the provisioning completed, you will be greeted with a command line prompt:

    ![Docker Quickstart Terminal.](docker_terminal.png)

5. Download the latest VILLASnode Docker image by runnning: `$ docker pull villas/node`

   ![Pulling VILLASnode Docker image.](docker_pull.png)

6. Test VILLASnode image by running: `$ docker run --privileged villas/node node -h`

   ![Running VILLASnode Docker image.](docker_run.png)

7. Enter an interactive VILLASnode shell by running: `$ docker run --privileged --tty --interactive --entrypoint bash villas/node`

    ![Docker run VILLASnode interactively](docker_run_interactive.png)

# Test installation {#node-installation-test}

Verify everything is working and required node-types are compiled-in:

```
$ villas node --help
```

Will print the current version including a list of all supported node-types, hooks, etc.

