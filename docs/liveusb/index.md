---
sidebar_position: 1
sidebar_label: Overview
---

# LiveUSB Image

This archive contains a disk image of a Fedora 29 installation which has been tuned for low latency and overall real-time performance.
It facilitates the setup of a VILLASnode instances by partners of the Institute for Automation of Complex Power Systems (ACS), EON Research Center, RWTH Aachen University.

## What you need

 - An USB drive with at least 8 GB capacity (the content on the drive will be erased, backup before if there are any important files stored!)
 - A computer running Windows, Mac OS X or Linux
 - A keyboard and display attached to the server
 - The live image file `.img.xz` which you can download here: <https://villas.fein-aachen.org/iso/>

## Setup {#liveusb-setup}

### Step 1: Getting the image onto the USB drive {#liveusb-setup-prepare}

**Note:** Simply copying the image onto the drive **does not work**!

1. Plug in your USB drive
2. Download, install and start the [_Fedora Media Writer_](https://getfedora.org/en/workstation/download/)
3. Download the [VILLAS Live ISO file](https://villas.fein-aachen.org/iso/)
4. Select "Custom image"
5. Pick the downloaded ISO file
6. Make sure that the correct USB drive is selected in the popup window
7. Make sure that the "Other" instead of "Raspberry Pi" is selected in the popup window
8. Click on "Write to disk"

### Step 2: Booting the system from the live USB image {#liveusb-setup-boot}

1. Shut down the server (and remove the old USB drive running an older version of VILLASnode, if there is any).
2. Plug in the USB drive and start the server. If the server does not boot into the USB drive, you may need to restart and change the boot order by pressing DEL or F12 at the very beginning of the start up.
3. When asked for user credentials, enter the default credentials:
   - **User**: root
   - **Password:** villas-admin

### Step 3: Testing functionality {#liveusb-setup-test}

1. Check the name and information about the running kernel with `uname -a`
2. If available, check the Internet connectivity with `ping www.rwth-aachen.de`. If the request times out, the internet is most likly not reachable.
3. If available, check the public IP address of the server with `curl canihazip.com/s`.
4. Check the network configurations with `ip addr show`.
5. Test installation of VILLASnode with `villas node --help`

### Step 4: Securing the system (options) {#liveusb-setup-security}

1. Change the default password: `passwd`.
2. Update the system regulary: `dnf update`
3. Setup a firewall: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7
