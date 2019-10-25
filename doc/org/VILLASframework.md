# Planning - VILLASframework {#org-framework}

## Overview

Main objective: getting the VILLAS framework (VILLASnode, VILLASfpga, VILLASweb) ready for demos and first public release

Overview of main milestones:

Num | Deadline | Objective
--- | --- | ---
Milestone 1 | End of February | VILLAS ready for internal testing
Milestone 2 | End of March | VILLAS ready to be shared with partners
Milestone 3 | End of April | VILLAS functionalies ready for public release
Milestone 4 | End of May | VILLAS doc ready for public release

### Main responsibilities:

Steffen:
- Getting VILLASnode stable (including functional websockets)
- VILLASfpga

Markus G.:
- Interface between VILLASnode and VILLASweb
- LabMashup visualisation based on new VILLASweb
- up to date live image for VILLASnode

Markus M.:
- scripts for automated testing (CI tests)

Marija:
- List with description and config files for test cases of VILLAS framework
- Execution and logging of manual tests with simulators
- Provide demo simulation examples (not only communication clients) for OPAL and RTDS with VILLAS framework (i.e. including VILLASnode and VILLASweb visualisation )


### List of requirements and tasks

Requirements:
- make sure that old VILLASweb and VILLASnode support FIWARE OCB
- a stable version of all components in VILLAS framework is needed
- GTNET SKT
  - include GTSYNC in testing
- Steffens thesis (VILLASfpga)
- multiple websocket clients connected to websocket server (works in the recent version, Markus G. to test) 
- websocket client on VILLASnode (Steffen)
    - Setting up new architecture with VILLAShub / central VILLASnode (Markus G.)
- Data structure for websockets (simulator ID...)
- Control of VILLASnodes / Simulation Manager
    - Functionalities in VILLASnode and VILLASweb
- LabMashup visualisation based on new VILLASweb
  - Adding figures
  - Charts with option to select the signal (like in old LabMashup)
  - Interaction (Markus G. to start from March)
    - Load(before sim)/download(after simulation) a file
    - Add a reference value

Other tasks:
- Documentation (everybody responsible)
- Public release
  - SoftwareX journal  

### Workflow
Org for testing branch, logs for manual testing…

## Other tasks

### VILLASweb for Gridhound (Artur)
- Create a mockup of what we want to have in VILLASweb (Marija and Markus)
  - We need to monitor also infrastructure, are simulators up, delays...
  - Meters, buttons...
- Getting VILLASweb ready to be shared with Artur
- User Guide 
    - Documentation of general purpose and overview of VILLASweb for Artur  
    - Description of entities and general functionalities of VILLASweb   
- Plan support from our side for VILLASweb
- Testing of Gridhound VILLASweb on OpenStack and with real VILLASnodes

## Future development
