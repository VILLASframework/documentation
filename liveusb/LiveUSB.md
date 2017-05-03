# LiveUSB Image {#liveusb}

This archive contains a disk image of a Fedora 23 installation which has been tuned for low latency and overall real-time performance. It facilitates the setup of a VILLASnode instances by partners of the Institute for Automation of Complex Power Systems (ACS), EON Research Center, RWTH Aachen University.

For direct support please contact [Steffen Vogel](stvogel@eonerc.rwth-aachen.de) or [Markus Grigull](mrigull@eonerc.rwth-aachen.de).

## Default Login Credentials

The default credentials are:

- User: `root`
- Password: `villas-admin`

On older versions (S2SS):

- User: `root`
- Password: `s2ss-admin`

## What you need

 - An USB drive with at least 4 GB capacity (the content on the drive will be erased, backup before if there are any important files stored!)
 - A computer running Windows, Mac OS X or Linux
 - A keyboard and display attached to the server
 - The live image ISO file `.iso`

## Setup
1. Getting the image onto the USB drive (Simply copying the image onto the drive **does not work**):
  1. When the host system is running Windows:
    1. Download the _USB Image Tool_ from: <http://www.alexpage.de/usb-image-tool/download/>
    1. Start the `USB Image Tool.exe` from the `usbit` folder.
    2. In the top left corner select _Device mode_.
    3. In the list on the left side select the USB drive.
    4. Click on restore. In the file open dialog select the `VILLASnode.img` image.
    5. Select `yes` to start copying the image onto the USB drive.
    6. When the copying is finished, the drive will not be readable by windows. This is intended, just unplug the drive.
  2. When running Linux: `sudo dd bs=1m if=VILLASnode.img of=/dev/sdX`
  3. When running Mac OS X:
    1. Open a terminal window and navigate (with `cd`) to the image location.
    2. Run `diskutil list` to get the list of connected drives (named `/dev/disk1`, `/dev/disk2` etc.). You need to identify the USB drive in the list. If you are not sure which drive the USB is, disconnect the USB, run the command again and compare which drive is now missing in the list.
    3. Run `sudo dd bs=1m if=VILLASnode.img of=/dev/diskX` where diskX is the drive you located in the list. This will take some time to finish.
    4. When the copying is finished, the drive will be reported as unreadable. This is intended, just eject the USB drive.
2. Running VILLASnode on the server:
  1. Shut down the server (and remove the old USB drive running an older version of VILLASnode, if there is any).
  2. Plug in the USB drive and start the server. If the server does not boot into the USB drive, you may need to restart and change the boot order by pressing DEL or F12 at the very beginning of the start up.
  3. When asked for user credentials, enter the default credentials. (You don't need to login every time you restart the server if you are working remotely).
3. Testing functionality (optional):
  1. Check the internet connectivity with `ping www.rwth-aachen.de`. If the request times out, the internet is most likly not reachable.
  2. Check the public IP address of the server with `curl canihazip.com/s`.
  3. Check if the network configurations are okay with `ip addr show`.

@subpage liveusb-build
