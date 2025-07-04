---
title: VILLASweb
sidebar_label: Overview
sidebar_position: 1
---

# VILLASweb <img src="/img/logos/villas_web.svg" width="115px" align="right" />

VILLASweb is a tool for configuring real-time co-simulations and displaying real-time simulation data in a web browser.
The term **frontend** refers to this project, which is the actual website.

The frontend connects to **two** backends:

- [VILLASweb-backend](https://github.com/VILLASframework/web-backend)
- [VILLASnode](https://github.com/VILLASframework/node)

The VILLASweb-backend, in turn, controls infrastructure components via the [VILLAScontroller](../controller/index.md) component.

_VILLASnode_ provides the actual simulation data via WebSockets.
_VILLASweb-backend_ provides all other data, such as user accounts, infrastructure components, configurations, dashboards, etc.
For more information about the backends, see their respective repositories.

