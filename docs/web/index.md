---
title: VILLASweb
sidebar_label: Overview
sidebar_position: 1
---

# VILLASweb <img src="/img/logos/villas_web.svg" width="115px" align="right" />

VILLASweb is a tool to configure real-time co-simulations and display simulation real-time data in the web browser.
The term **frontend** refers to this project, the actual website.

The frontend connects to **two** backends:

- [VILLASweb-backend-go](https://github.com/VILLASframework/web-backend)
- [VILLASnode](https://github.com/VILLASframework/node)

The VILLASweb-backend in turn controls infrastructure components via the [VILLAScontroller](../controller/index.md) component

_VILLASnode_ provides actual simulation data via websockets.
_VILLASweb-backend-go_ provides any other data such as user accounts, infrastructure components and configurations, dashboards etc.
For more information on the backends see their repositories.

