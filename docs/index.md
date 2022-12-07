---
title: VILLASframework
sidebar_position: 1
---

# VILLASframework <img src="/img/logos/villas_framework.svg" align="right" width="150px" />

Welcome to the documentation of the VILLASframework.

# VILLASframework

VILLASframework is a toolset for local and geographically distributed real-time co-simulation.

## Real-time networking of test benches

Real-time simulators are already used extensively for academic research as well as industrial applications in electrical power networks.
The primary application of real-time simulators is in the area of hardware-in-the-loop (HiL) simulation.
In this context, HIL simulation integrates simulated components with a physical DUT in a feedback loop.
In this way, the interactions of real components in a virtual overall system can be investigated with the aid of simulated subsystems.
In addition to cost savings during development, HiL simulation enables the validation of components even for contingencies that cannot be realized without simulation.

An extension of the HiL approach is Geographically Distributed Real Time Simulation (GD-RTS), in which the simulation infrastructure, consisting of component test benches as well as simulation hardware, is not installed at one location, but is used coupled across geographical distances.
Since in HiL simulations the communication latencies between simulation hardware and test benches have a direct influence on the mappable dynamic range of the simulation, long distances between coupled test benches are a particular challenge.
However, the potential of such a Geographically Distributed Real Time Simulation (GD-RTS) is large.
While in classical HiL simulation investigations with several test benches or different simulation hardware are difficult to implement due to high acquisition costs and special requirements, the geographically distributed simulation allows to use existing simulation infrastructure coupled at different locations.
The integration of different test bench components enables the interaction between interdisciplinary teams of experts whose collaboration on joint component tests was not possible before. 
For manufacturers and/or certifiers, geographically distributed simulation enables remote access to simulation infrastructure without having to move components or personnel between locations.
Another advantage is the assurance of confidentiality of, for example, model data, which in such a simulation only leaves the communication infrastructure of a network participant via defined interface.

## VILLASframework

VILLAS is framework for coupling test beds and real-time simulators between geographically distributed laboratories.
The development of VILLAS is mainly driven by RWTH Aachen University and was originally designed here for geographically distributed real-time simulation of electrical networks, but can also be used without restrictions for simulation in other domains as well as multi-physical systems.

The framework consists of several independent components, which can be combined according to requirements and needed functions.

Central is _VILLASnode_ as interface for the coupling between the involved components.
It enables real-time data exchange via various protocols and data formats.

In addition, _VILLASweb_ provides a web-based user interface with which scenarios, user groups, laboratory infrastructure and measurement results can be managed.
The execution of experiments can be monitored and controlled by means of a freely programmable virtual control room.
For this purpose, real-time data can be transferred directly to the web-based control room via the _VILLASnode_ interface.

The configuration, inventory and control of the involved laboratory infrastructure is realized via the _VILLAScontroller_, which exchanges the current status as well as control commands and configurations between the virtual control room and the laboratory infrastructure.

The modular structure of the framework allows easy extensibility with new interfaces, protocols and data formats.
This is supported by the open development approach, which makes the framework fully available as open source software under the Apache 2.0 license to external users, allowing them to collaborate on the common code base.

VILLAS can therefore be used as a manufacturer-independent tool for coupling various components and has already been in use for several years at approx. 29 universities and research institutions (https://villas.fein-aachen.org/docs/users).
The efficiency of VILLASframework was already proven in several national, as well as international research projects.
Further publications on the VILLASframework are available at https://villas.fein-aachen.org/docs/publications.

It is actively developed by the [Institute for Automation of Complex Power Systems](https://www.acs.eonerc.rwth-aachen.de/) at the [RWTH Aachen University](https://www.rwth-aachen.de).

:::caution
For starters we recommend to read the **[installation guide](installation.md)**!
:::

## Components

VILLASframework consists of several components:

<ul style={{listStyleType: 'none', fontSize: '1.5em', fontWeight: 'bold'}}>
    <li><a href="./node/"><img style={{height: '1.5em'}} src="/img/logos/villas_node.svg"></img>       VILLASnode</a></li>
    <li><a href="./web/"><img style={{height: '1.5em'}} src="/img/logos/villas_web.svg"></img>        VILLASweb</a></li>
    <li><a href="./controller/"><img style={{height: '1.5em'}} src="/img/logos/villas_controller.svg"></img> VILLAScontroller</a></li>
    <li><a href="./fpga/"><img style={{height: '1.5em'}} src="/img/logos/villas_fpga.svg"></img>       VILLASfpga</a></li>
</ul>

## Download

The source code of all open source components is available via [GitHub](https://github.com/VILLASframework).

## Copyright

2014-2022, Institute for Automation of Complex Power Systems, EONERC

## Licensing

<img alt="GPLv3 logo" src="/img/logos/gplv3.png" width="120" align="right" />

__VILLASnode__, __VILLASfpga__, __VILLAScontroller__ and __VILLASweb__ are released as open source software under the [GPLv3 license](https://www.gnu.org/licenses/gpl-3.0.en.html).

__VILLASdataprocessing__ is released as open source software under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

Other licensing options available upon request.
Please contact [Prof. Antonello Monti](mailto:amonti@eonerc.rwth-aachen.de) for further details.

## Contact / Mailing list

The project is using a public [mailing list](https://mailman.rwth-aachen.de/mailman/listinfo/villas) for announcements and general discussions.
Please click on the link above to subscribe.

[Steffen Vogel](mailto:svogel2@eonerc.rwth-aachen.de) is coordinating development of VILLASframework and its application in project at ACS.

[Institute for Automation of Complex Power Systems (ACS)](http://www.acs.eonerc.rwth-aachen.de)  
[EON Energy Research Center (EONERC)](http://www.eonerc.rwth-aachen.de)  
[RWTH University Aachen, Germany](http://www.rwth-aachen.de)  

<img alt="EONERC ACS Logo" src="/img/logos/eonerc_logo.png" align="right" />

## Funding

Funding is provided by the following research projects:

- **[RESERVE](http://re-serve.eu/)**: European Unions Horizon 2020 research and innovation programme under grant agreement No 727481.
- **[VILLAS](https://villas.fein-aachen.org/website/)**: Funding provided by [JARA-ENERGY](http://www.jara.org/en/research/energy). Jülich-Aachen Research Alliance (JARA) is an initiative of RWTH Aachen University and Forschungszentrum Jülich.
- **[Urban Energy Lab 4.0](http://www.acs.eonerc.rwth-aachen.de/go/id/qxvw)**: Funding is provided by the [European Regional Development Fund (EFRE)](https://ec.europa.eu/regional_policy/en/funding/erdf/).
