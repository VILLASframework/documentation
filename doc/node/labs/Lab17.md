# Lab 17: RTDS-RTDS Co-simulation {#node-guide-lab17}

This lab demonstrates the use of the VILLASnode gateway to couple two RTDS digital real-time simulators in a co-simulation of a simple power system.

## Simple Power System

tbd

## RTDS CoSiF library for Dynamic Phasor Interface 

tbd

## Requirements

The setup requires the following components:

* 1x Linux workstation or server running the VILLASnode gateway
  * Checkout the [installation instructions](@ref node-installation) for further details.
* 2x RTDS GPC / PB5 racks or Novacor Chassis
* 2x GTNET card running the GTNET-SKT firmware
  * Used for co-simulation interface signals
  * Each rack is connected to one GTNET card
* 1x GTNET card running the GTNET-SKT firmware (optional)
  * Used for monitoring the simulation in VILLASweb
* RSCAD drafts of the [SimplePowerSystem](https://git.rwth-aachen.de/acs/public/simulation/cosif/-/tree/master/DynamicPhasors/RTDS/SimplePowerSystem)


## IP Addresses used in this example

| Device                    | Address        | GPC Card | GTIO Port # |
|:--                        | :--            |:--       |:---         |
| VILLASnode                | 134.130.169.31 | ---      | ---         |
| GTNET Rack 1              | 134.130.169.XX |          |             |
| GTNET Rack 1 (monitoring) | 134.130.169.XX |          |             |
| GTNET Rack 2              | 134.130.169.XX |          |             |

## VILLASnode configuration

@includelineno node/etc/labs/lab17.conf

## Setup procedure for RTDS racks

1. Prepare two RSCAD workstations.
  - One for each rack respectively.
  - Complete the remaining steps for each rack/workstation
1. Write down the IP addresses and GTIO port the GTNET card
1. Download the SimplePowerSystem draft (see link above)
1. Open the ss1 / ss2 Subsystems on Rack 1 /  Rack 2 respectively
1. Adjust the rack number for your setup
1. Adjust the conrol processor mapping
1. Adjust the GTIO port number of the GTNET-SKT block inside the draft
1. Compile the model

## Setup procedure for VILLASnode gateway(s)



## Startup procedure

1. Login to the Linux workstation
    1. Run `sudo villas node /path/to/your/lab17.conf`
1. On each RSCARD workstation
    1. Load the runtime
    1. Start the simulation
    1. Check if system is stable
1. On RSCAD runtime of `ss1`
  1. 
1. On RSCAD runtime of `ss2`


## Monitoring the simulation


Signal list:

https://git.rwth-aachen.de/acs/public/simulation/cosif/-/blob/master/DynamicPhasors/RTDS/SimplePowerSystem/SimplePowerSystem_Distributed_v18/ss1/monitoring_skt_to.txt