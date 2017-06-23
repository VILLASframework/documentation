# LiveUSB Image {#liveusb}

- @subpage liveusb-build
- @subpage liveusb-installation

This archive contains a disk image of a Fedora 24 installation which has been tuned for low latency and overall real-time performance. It facilitates the setup of a VILLASnode instances by partners of the Institute for Automation of Complex Power Systems (ACS), EON Research Center, RWTH Aachen University.

# What you need

 - An USB drive with at least 4 GB capacity (the content on the drive will be erased, backup before if there are any important files stored!)
 - A computer running Windows, Mac OS X or Linux
 - A keyboard and display attached to the server
 - The live image ISO file `.iso` which you can download here: <https://villas.fein-aachen.org/iso/>

# Setup {#liveusb-setup}

## Step 1: Getting the image onto the USB drive {#liveusb-setup-prepare}

Note: Simply copying the image onto the drive **does not work**!

1. When the host system is running Windows:
  1. Download the _USB Image Tool_ from: <http://www.alexpage.de/usb-image-tool/download/>
  1. Start the `USB Image Tool.exe` from the `usbit` folder.
  2. In the top left corner select _Device mode_.
  3. In the list on the left side select the USB drive.
  4. Click on restore. In the file open dialog select the `villas-live-x.iso` image (enable `All files (*.*)` in the file type dropdown list).
  5. Select `yes` to start copying the image onto the USB drive.
  6. When the copying is finished, the drive will not be readable by Wndows. This is intended, just unplug the drive.
2. When running Linux: `sudo dd bs=1m if=VILLASnode.img of=/dev/sdX`
3. When running Mac OS X:
  1. Open a terminal window and navigate (with `cd`) to the image location.
  2. Run `diskutil list` to get the list of connected drives (named `/dev/disk1`, `/dev/disk2` etc.). You need to identify the USB drive in the list. If you are not sure which drive the USB is, disconnect the USB, run the command again and compare which drive is now missing in the list.
  3. Run `sudo dd bs=1m if=VILLASnode.img of=/dev/diskX` where diskX is the drive you located in the list. This will take some time to finish.
  4. When the copying is finished, the drive will be reported as unreadable. This is intended, just eject the USB drive.

## Step 2: Booting the system from the live USB image {#liveusb-setup-boot}

1. Shut down the server (and remove the old USB drive running an older version of VILLASnode, if there is any).
2. Plug in the USB drive and start the server. If the server does not boot into the USB drive, you may need to restart and change the boot order by pressing DEL or F12 at the very beginning of the start up.
3. When asked for user credentials, enter the default credentials: root (without password).    

**Note:** For the persistent setup, install the image on your machine (see  Step 3). As soon as you reboot the system booted from the live USB image, all your changes, settings, files are deleted. 

## Step 3: Installing the system on the machine {#liveusb-setup-install}

**Warning:** This step will erase all files which have been previously on the internal harddisk of the machine!

1. Start installation with `liveinst`
2. Refer to the video @subpage liveusb-installation
3. Shutdown the server and remove the USB drive 
4. Start the server and test functionality (Step 4)

## Step 4: Testing functionality {#liveusb-setup-test}

1. Check the name and information about the running kernel with `uname -a`
2. Test installation of VILLASnode with `villas node --help`
3. If available, check the Internet connectivity with `ping www.rwth-aachen.de`. If the request times out, the internet is most likly not reachable.
4. If available, check the public IP address of the server with `curl canihazip.com/s`.
5. Check the network configurations with `ip addr show`.

## Step 5: Configure Firewall {#liveusb-setup-firewall}

By default, the installed Linux system only accepts SSH and ICMP traffic.
For using VILLASnode additional UDP ports must be opened manually.

1. Create a new firewall zone for VILLASnode: `firewall-cmd --permanent --new-zone=villas`
2. Allow UDP traffic on ports 12000 to 12010: `firewall-cmd --permanent --zone=villas --add-port=12000-12010/udp`
3. Add sources to zone: `firewall-cmd --permanent --zone=villas --add-source=10.10.15.0/24`
4. Apply new configuration `firewall-cmd --reload`

# Contact

For direct support please contact:

- [Steffen Vogel](stvogel@eonerc.rwth-aachen.de)
- [Markus Grigull](markus.grigull@rwth-aachen.de).
