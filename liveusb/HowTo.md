# Build new LiveUSB images {#liveusb-build}

### Create image

**Attention:**  This guide was created with Fedora 23. Setup may change with newer versions. Basic linux, ssh, scp and dnf package manager
            usage are required. Also the realtime kernel is required. If no realtime kernel is provied for the newest version choose
            the latest with realtime kernel support.

1. Installing fedora server in a virtual machine.  
  1. Download the latest fedora server iso (http://getfedora.org).  
  2. Create a new virtual machine in VirtualBox with type 'linux' and version 'Fedora (64-Bit)'. The disk should be dynamic allocated and about 4 GB.  
  3. Insert the fedora server iso in the virtual optical drive and start the machine.  
  4. In the installation summary, select installation destination to configure the disks.  
    1. Choose the only available hard drive, select 'I will configure partitioning.' and press done.  
    2. In the manual partitioning window, do not add a partitioning scheme but create your own by clicking the plus sign.  
    3. Select '/' as mount point, enter the whole disk size (e.g. 4 GB) and add the mount point.  
    4. With the new partition selected, change the device type to 'Standard Partition', the filesystem to 'ext4' and press done.  
    5. Ignore the warning for not having a swap partition and apply the changes.  
  5. Back in the installation summary, select software installation, choose 'Minimal Install' in the list and press done.  
  6. Begin the installation.  
  7. While installing set the root password (If your password is too weak you have to press done twice).  
  8. When the installation is finished reboot the device and login (Don't forget to remove the fedora iso from the virtual optical drive before booting).  
  9. From now on you may login with SSH to avoid using the VirtualBox terminal window.  
2. Installing the realtime kernel (https://docs.fedoraproject.org/en-US/Fedora/16/html/Musicians_Guide/sect-Musicians_Guide-Getting_Real_Time_Kernel_in_Fedora.html).  
  1. Install the Planet CCRMA repositories.  
    1. Install the repositories `$ rpm -Uvh http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetccrma/23/i386/planetccrma-repo-1.1-3.fc23.ccrma.noarch.rpm` (If you
            install a different version of fedora the URL changes, might be just replacing the version numbers in this URL; Please verify the URL before installing).  
    2. Update all packages with `$ dnf update`.  
  2. Install the realtime kernel with `$ dnf install planetccrma-core`.  
  3. Reboot into the new realtime kernel (you may have to select it in grub) and verify the new kernel is running with `$ uname -r` (The release should have '+rt' in the name).  
  4. Remove unneeded kernels (**Hint:** You should leave one non-realtime kernel installed).  
    1. List all installed kernels with `$ dnf info kernel`. (To list all realtime kernels replace 'kernel' with 'kernel-rt').  
    2. Remove unneeded kernels with `$ dnf remove kernel-<version>` where <verison> is the kernel version to remove.  
    3. Goto '/boot' and list all files.  
    2. Remove all files regarding the previous uninstalled kernel versions.  
  5. Change grub to boot by default into the realtime kernel.  
    1. Open /etc/default/grub and ensure the line 'GRUB_DEFAULT=saved' exists and 'GRUB_SAVEDEFAULT=false' does not exist.  
    2. Update the grub config file with `$ grub2-mkconfig -o /boot/grub2/grub.cfg`.  
    3. Get the menu entry names with `$ grep -P "submenu|^menuentry" /boot/grub2/grub.cfg | cut -d "'" -f2`.  
    4. Set the default kernel with `$ grub2-set-default "<name>"` where <name> is the line with the realtime kernel printed earlier (e.g. "Fedora (4.4.4-301.rt11.1.fc23.ccrma.x86_64+rt) 23 (Twenty Three)").  
3. Install tuned with realtime profile (https://fedorahosted.org/tuned/).  
  1. Install the program with `$ dnf install tuned tuned-profiles-realtime`.  
  2. Start the service with `$ systemctl start tuned.service`.  
  3. Enable automatic start with system startup with `$ systemctl enable tuned.service`.  
  4. Switch to realtime profile with `$ tuned-adm profile realtime`.  
4. Install tinc VPN.  
  1. Install wget and tar if needed with `$ dnf install wget tar`.  
  2. Download tinc VPN 1.1pre11 source code from website with `$ wget https://www.tinc-vpn.org/packages/tinc-1.1pre11.tar.gz`.  
  3. Unpack the donwloaded archive with `$ tar -xzvf tinc-1.1pre11.tar.gz` and go into the new tinc directory.  
  4. Install build tools and dependencies with `$ dnf install gcc ncurses-devel readline-devel zlib-devel lzo-devel openssl-devel`.  
  5. Build tinc with `$ ./configure && make && make install`.  
  6. Ensure tinc VPN is installed with `$ tinc --version`.  
5. Copy S2SS image files from the InetDistSim repository, liveusb/files directory (https://github.com/RWTH-ACS/InetDistSim/tree/master/liveusb).  
  1. Copy from the 'etc' directory 'motd', 'hostname', 'hosts', 'image-release' files and 'image', 'modprobe.d', 'sysconfig' and 'systemd' directories into /etc with `$ scp -r <path> root@<ip>:/etc` where
        <path> is the path the file or directory on your locale machine and ip the address to the virtual machine (You may also copy the whole InetDistSim repository into the virtual machine and
        copy the files locally).  
  2. Copy the '.ssh' directory in '/root' onto the virtual machine with `$ scp -r <path> root@<ip>:/root` where <path> is the path to the '.ssh' directory.  
  3. **Important:** Protect ssh keys otherwise they are not used `$ chmod 600 ~/.ssh/id_rsa_*`.
  4. Install needed packages with `$ dnf install traceroute lshw ssmtp bind-utils`.  
  5. Configure SSMTP to use tunneled mailserver.
    1. Open '/etc/ssmtp/ssmtp.conf', set 'mailhub' to 'localhost:25' and 'Hostname' to '0l.de'.
  6. Enable the setup.sh script on boot with `$ systemctl enable setup`.
6. Remove unwanted packages.
  1. List all installed packages with `$ dnf list installed`.
  2. Remove packages with `$ dnf remove <name>` where <name> is the name of unwanted packages.
7. Prepare the virtual disk for compression.  
  1. Write a file zero file to disk with `$ dd if=/dev/zero of=large bs=1G count=<X>` where <X> is the number of gigabytes of the virtual disk.  
  2. Sync the file to be written to the virtual disk with `$ sync`.  
  3. Delete the file with `rm large`.  
8. Convert the virtual disk to raw image.  
  1. Shutdown the virtual machine.  
  2. Goto the directory containing the '.vdi' file.  
  3. Convert the virtual disk with `$ VBoxManage internalcommands converttoraw <image.vdi> image.raw` where <image.vdi> is the name of the '.vdi' file.  
  4. Compress the file and upload.  
9. Copy the raw image to physical disk (The physical disk must have at least the size of the virtual disk).  
  1. Locate and unmount the disk.  
  2. Copy the image to disk with `sudo dd bs=10m if=image.raw of=/dev/<sdX>` where <sdX> is the unmounted disk.  


### Troubleshoot
 - Error booting: Boot rescue kernel and reinstall kernel-core (in this case kernel-rt-core) with `$ dnf reinstall kernel-rt-core`.
 - Error running s2ss because not finding dynamic libs2ss.so: Add in '/etc/ld.so.conf' the line '/usr/local/lib' and reload the ld cache with `$ ldconfig`.
 - SSH connection ask for password: SSH keys need to be set to `$ chmod 600 ~/.ssh/id_rsa_*`.
