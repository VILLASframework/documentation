---
sidebar_position: 17
---

# Lab 17: RTDS-RTDS Co-simulation

This lab demonstrates the use of the VILLASnode gateway to couple two RTDS digital real-time simulators in a co-simulation of a simple power system.

## Simple Power System

tbd

## RTDS CoSiF library for Dynamic Phasor Interface 

tbd

## Requirements

The setup requires the following components:

* 1x Linux workstation or server running the VILLASnode gateway
  * Checkout the [installation instructions](../installation.md) for further details.
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

``` url="external/node/etc/labs/lab17.conf" title="node/etc/labs/lab17.conf"
nodes = {
    rtds_ss1 = {
        type = "socket"
        layer = "udp"
        format = {
            type = "gtnet"
            fake = true
        }

        in = { # Local address, i.e. address of villas instance
            address = "134.130.169.31:12000"

            signals = (
                { name="trigger", type="integer" },
                { name="if1_tx_phA_dp0_mag",   type="float" },
                { name="if1_tx_phA_dp0_phase", type="float" },
                { name="if1_tx_phA_dp1_mag",   type="float" },
                { name="if1_tx_phA_dp1_phase", type="float" },
                { name="if1_tx_phA_dp2_mag",   type="float" },
                { name="if1_tx_phA_dp2_phase", type="float" },
                { name="if1_tx_phA_dp3_mag",   type="float" },
                { name="if1_tx_phA_dp3_phase", type="float" },
                { name="if1_tx_phB_dp0_mag",   type="float" },
                { name="if1_tx_phB_dp0_phase", type="float" },
                { name="if1_tx_phB_dp1_mag",   type="float" },
                { name="if1_tx_phB_dp1_phase", type="float" },
                { name="if1_tx_phB_dp2_mag",   type="float" },
                { name="if1_tx_phB_dp2_phase", type="float" },
                { name="if1_tx_phB_dp3_mag",   type="float" },
                { name="if1_tx_phB_dp3_phase", type="float" },
                { name="if1_tx_phC_dp0_mag",   type="float" },
                { name="if1_tx_phC_dp0_phase", type="float" },
                { name="if1_tx_phC_dp1_mag",   type="float" },
                { name="if1_tx_phC_dp1_phase", type="float" },
                { name="if1_tx_phC_dp2_mag",   type="float" },
                { name="if1_tx_phC_dp2_phase", type="float" },
                { name="if1_tx_phC_dp3_mag",   type="float" },
                { name="if1_tx_phC_dp3_phase", type="float" }
            )
        }

        out = { # Remote address, i.e. address of GTNET card
            address = "134.130.169.97:12000" # GTNET#4 -> Rack5(GPC4)
        }
    }

    rtds_ss2 = {
        type = "socket"
        layer = "udp"
        format = {
            type = "gtnet"
            fake = true
        }

        in = {
             # Local address, i.e. address of villas instance
            address = "134.130.169.31:12001"

            signals = (
                { name="trigger", type="integer" },
                { name="if1_tx_phA_dp0_mag",   type="float" },
                { name="if1_tx_phA_dp0_phase", type="float" },
                { name="if1_tx_phA_dp1_mag",   type="float" },
                { name="if1_tx_phA_dp1_phase", type="float" },
                { name="if1_tx_phA_dp2_mag",   type="float" },
                { name="if1_tx_phA_dp2_phase", type="float" },
                { name="if1_tx_phA_dp3_mag",   type="float" },
                { name="if1_tx_phA_dp3_phase", type="float" },
                { name="if1_tx_phB_dp0_mag",   type="float" },
                { name="if1_tx_phB_dp0_phase", type="float" },
                { name="if1_tx_phB_dp1_mag",   type="float" },
                { name="if1_tx_phB_dp1_phase", type="float" },
                { name="if1_tx_phB_dp2_mag",   type="float" },
                { name="if1_tx_phB_dp2_phase", type="float" },
                { name="if1_tx_phB_dp3_mag",   type="float" },
                { name="if1_tx_phB_dp3_phase", type="float" },
                { name="if1_tx_phC_dp0_mag",   type="float" },
                { name="if1_tx_phC_dp0_phase", type="float" },
                { name="if1_tx_phC_dp1_mag",   type="float" },
                { name="if1_tx_phC_dp1_phase", type="float" },
                { name="if1_tx_phC_dp2_mag",   type="float" },
                { name="if1_tx_phC_dp2_phase", type="float" },
                { name="if1_tx_phC_dp3_mag",   type="float" },
                { name="if1_tx_phC_dp3_phase", type="float" }
            )
        }

        out = {
            # Remote address, i.e. address of GTNET card
            address = "134.130.169.98:12000" # GTNET#5 -> Rack1(GPC4)
        }
    }

    rtds_ss1_monitoring = {
        type = "socket"
        layer = "udp"
        format = {
            type = "gtnet"
            fake = true
        }

        in = { # Local address, i.e. address of villas instance
            address = "134.130.169.31:12002"

            signals = (
                { name="orgn_V3phRMSintrf", type="float", unit="V"   },
                { name="orgn_Pintrf", type="float", unit="W"   },
                { name="orgn_Qintrf", type="float", unit="Var" },
                { name="orgn_Sintrf", type="float", unit="VA"  },
                { name="if1_V3phRMS", type="float", unit="V"   },
                { name="if1_I3phRMS", type="float", unit="A"   },
                { name="if1_P",       type="float", unit="W"   },
                { name="if1_Q",       type="float", unit="Var" },
                { name="if1_S",       type="float", unit="VA"  }
            )
        }

        out = { # Remote address, i.e. address of GTNET card
            address = "134.130.169.97:12000"
        }
    }


    web_monitoring = {
        type = "websocket"

        destinations = [
            "https://villas.k8s.eonerc.rwth-aachen.de//ws/relay/lab17"
        ]
    }
}

paths = (
    {
        in = "rtds_ss1"
        out = "rtds_ss2"
        reverse = true
    },
    {
        enabled = false
        in = "rtds_ss1_monitoring"
        out = "web_monitoring"
        reverse = true
    }
)
```

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
