# RTDS GTNET-SKT card {#node-client-gtnet}

**Example drafts:** <https://git.rwth-aachen.de/acs/public/villas/VILLASnode/tree/develop/clients/rtds/GTNETv2_SKT>

The GTNETx2 card can be upgraded with SKT firmware to send/receive UDP and TCP packets over Ethernet.
The card uses big endian byte order to send and receives data.

There are two ways to exchange data with VILLASnode which are implemented by the @ref node-type-socket node-type.

 - **Without a header:** Only data values are sent without any header information like sequence number or timestamps.
    This option is configured by setting @ref node-config-node-socket-header to `gtnet-skt:fake` in tge configuration file.
 - **With a header:** First 3 values are interpreted as sequence no, timestamp seconds and timestamp nanoseconds.
    A timestamp can be added by using the GTSYNC card with a GPS source in the draft file.
    Alternatively, if no timestamp is provided (value set to 0), VILLASnode will add a timestamp and thereby overriding replacing the 0 value.
 
## Common Problems

Problems faced during setting up of GTNET-SKT card with GTSYNC card are:

### The GTNET-SKT is not detected

The GTNET-SKT card was not detected in the RSCAD config manager because the GPC processor port was faulty.
Shifting the GTNET-SKT card to another port solved the issue.
Also check the fiber cable if that is faulty.

### The GTNET-SKT display shows wrong protocol

The GTNET-SKT display should display the correct processor number and the protocol version.
Use the `SEL` button to toggle between processor and protocol display.
The processor value should be of the form i.e. 3.1 (processor 3 GT port 1) and the protocol should be 15 which is GTNET-SKT.
If the protocol is 16 there is an error.
Also processor number 0.0 means the GT-SKT card can’t detect the processor.

### Outdated GTWIF firmware

Check that GTWIF Firmware version is 4.104 build 7 or higher and RSCAD version is 4.003.1 or higher.
In case the GTNET-SKT can’t detect the processor, restart the rack after repeating step 1.

In case GT-SKT can’t detect a correct protocol, telnet (login: `rtds`, password: `commcard`) into the card and run the command `status` to see which protocol version the card has.

If the card doesn’t display the correct protocol in the telnet but the “Firmware Upgrade” in RSCAD shows the correct version, downgrade the version in Firmware upgrade and then upgrade it to the desired version.
 
### Timing source not synced
 
In case the draft file gives an error “Timing source not synced”, the GTSYNC card is not connected to GPS source.

## Contact
 
Author: Umar Farooq <umar.farooq@rwth-aachen.de>
