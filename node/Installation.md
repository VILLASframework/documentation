# Installation {#node-installation}

VILLASnode can be installed in multiple ways:

- Using a pre-build Docker image
- Using pre-build RPM packages for Redhat based Linux distributions
- Using a bootable Linux live image
- or from source

# Bootable Linux live image  {#node-installation-live}

See: @ref liveusb

# From RPM packages {#node-installation-rpm}

## With internet access by using VILLAS RPM repository {#node-installation-rpm-offline}

Add VILLAS RPM repository to your system:

```
$ sudo dnf config-manager --add-repo https://villas.fein-aachen.org/packages/villas.repo
Adding repo from: https://villas.fein-aachen.org/packages/villas.repo
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

1. Download the latest .rpm files from: https://villas.fein-aachen.org/packages/x86_64/
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

VILLASnode can be compiled from source. This process has been tested with Fedora 25, Debian 8 (Jessie) and Ubuntu 16.04 (Xenial).

## Prerequisites

VILLASnode currently has the following list of dependencies:

 - [openssl](https://www.openssl.org) for cryptographic hashing functions (_required_).
 - [libconfig](http://www.hyperrealm.com/libconfig/) for parsing the configuration file (_required_).
 - [libnl3](http://www.infradead.org/~tgr/libnl/) for the network communication & emulation support of the @ref node-type-socket node-type.
 - [libjansson](http://www.digip.org/jansson/) JSON parser for @ref node-type-websocket and @ref node-type-ngsi node-types (_required_).
 - [libwebsockets](http://libwebsockets.org) for the @ref node-type-websocket node-type (_required_).
 - [libcurl](https://curl.haxx.se/libcurl/) for HTTP REST requests by the @ref node-type-ngsi node-type.
 - [libzmq](http://zeromq.org) for the @ref node-type-zeromq node-type.
 - [libnanomsg](http://nanomsg.org/) for the @ref node-type-nanomsg node-type.
 - [libiec61850](http://libiec61850.com/libiec61850/) for the @ref node-type-iec61850-8-1 and @ref node-type-iec61850-0-2 node-types.
 - [libOpal{AsyncApi,Core,Utils}](https://git.rwth-aachen.de/VILLASframework/libopal) for running VILLASnode as an Asynchronous process inside your RT-LAB model.
 - [libxil](https://git.rwth-aachen.de/VILLASframework/libopal) for Xilinx drivers of the @ref node-type-fpga node-type.
  
There are two ways to install these dependencies:

1. You can most of the dependencies using the package manger of your Linux distribution:
 
Use the following command to install the dependencies under Debian-based distributions:

```
$ sudo apt-get install \
    gcc g++ \
	pkg-config make cmake \
	autoconf automake autogen libtool \
	flex bison \
	texinfo git curl \
    make cmake \
    git curl tar \
    doxygen dia \
    graphviz \
    libsodium-dev \
    libpgm-dev \
    libssl-dev \
    libconfig-dev \
    libnl-3-dev libnl-route-3-dev \
    libjansson-dev \
    libcurl4-openssl-dev \
    libzmq3-dev \
    libnanomsg-dev
```

or the following line for Fedora / CentOS / Redhat systems:

```
$ sudo dnf install \
    gcc gcc-c++ \
	pkgconfig make cmake \
	autoconf automake autogen libtool \
	flex bison \
	texinfo git curl tar \
    doxygen dia \
    graphviz \
    openssl-devel \
    libconfig-devel \
    libnl3-devel \
    jansson-devel \
    libcurl-devel \
    zeromq-devel \
    nanomsg-devel
```

 2. Alternatively, you can use the build system to download, compile and install all dependencies:
 
```
$ make install-thirdparty
``` 
 
## Downloading from Git

```
$ git -c submodule."thirdparty/libopal".update=none clone --recursive https://git.rwth-aachen.de/VILLASframework/VILLASnode.git
$ cd VILLASnode
```

**Note:** The libopal submodule contains software from OPAL-RT which we can not release. Therefore we do not try to clone it by default. Please contact [Steffen Vogel](mailto:svogel2@eonerc.rwth-aachen.de) to get access.

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

