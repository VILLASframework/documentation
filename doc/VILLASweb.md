# VILLASweb {#web}

<img src="images/logos/villas_web.svg" width="115px" align="right" />

VILLASweb is a tool to configure real-time co-simulations and display simulation real-time data in the web browser.
The term **frontend** refers to this project, the actual website.
The frontend connects to **two** backends:
- [VILLASweb-backend-go](https://git.rwth-aachen.de/acs/public/villas/web-backend-go)
- [VILLASnode](https://git.rwth-aachen.de/acs/public/villas/node)

_VILLASnode_ provides actual simulation data via websockets.
_VILLASweb-backend-go_ provides any other data such as user accounts, infrastructure components and configurations, dashboards etc.
For more information on the backends see their repositories.

- @subpage web-screenshots
- @subpage web-data-model
- Usage
  - @subpage web-usage-backend
- @subpage web-development
  - @subpage web-branding
  - @subpage web-authentication
  - @subpage web-development-backend
  - @subpage web-development-frontend
