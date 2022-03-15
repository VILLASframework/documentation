---
hide_table_of_contents: true
---

# WebRTC

The `webrtc` node-type exchanges messages via the [WebRTC](https://webrtc.org/) protocol.
It allows peer-to-peer data exchange with minimal configuration between two VILLASnode instances or a VILLASnode instance and a web-browser.

The node-type uses [WebRTC data-channels](https://developer.mozilla.org/en-US/docs/Web/API/RTCDataChannel) to transport the sample data which can be formatted in any of the [supported format-types](../formats/index.md).
Data-channels establish an encrypted transport using the [SCTP](https://en.wikipedia.org/wiki/Stream_Control_Transmission_Protocol) and [DTLS](https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security) protocols.
DTLS itself is transported over UDP and therefore benefits from the same advantages as UDP for low-latency real-time communication.

In addition, WebRTC fully automates the process connection establishment.
Users do not have to exchange IP addresses or port numbers as for the [`socket` node-type](./socket.md).
Instead just a common session name needs to be agreed on between the two nodes.
Under the hood a signaling server is used for exchanging address and session information.

:::info To summarize

**The WebRTC node-type allows you to couple simulators and labs as easy as a Zoom/Skype video conference 📺.**

:::

**See also:** The [WebSocket node-type](./websocket.md) is a related but older node-type.

## Prerequisites

This node-type is implemented in [Go](https://go.dev/).
VILLASnode must be build with the CMake option `-DWITH_GO=ON` (enabled by default).

A publicly reachable signaling server is required.
[RWTH-ACS](https://www.acs.eonerc.rwth-aachen.de) operates such a signaling server at `wss://ws-signal.villas.k8s.eonerc.rwth-aachen.de` which is used by default.

## Implementation

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/go/pkg/nodes/webrtc/

## Web Demo {#demo}

There exists an example WebRTC peer implementation running in a web-browser:

- **Source:** https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/web/webrtc.html
- **Online Demo:** https://villas.fein-aachen.org/webrtc/

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/webrtc" />

## Example

``` url="external/node/etc/examples/nodes/webrtc.conf" title="node/etc/examples/nodes/webrtc.conf"
nodes = {
	webrtc_node = {
		type = "webrtc",

		format = "json"

		# A unique session identifier which must be shared between two nodes
		session = "my-session-name"

		# Address to the websocket signaling server
		server = "wss://ws-signal.villas.k8s.eonerc.rwth-aachen.de"

		# Setting for Interactive Connectivity Establishment
		ice = {
			# List of STUN/TURN servers
			servers = (
				{
					urls = [
						"stun:stun.0l.de:3478",
						"turn:turn.0l.de:3478?transport=udp",
						"turn:turn.0l.de:3478?transport=tcp"
					],

					# Credentials for TURN servers
					username = "villas"
					password = "villas"
				}
			)
		}
	}
}
```

## Further reading

- [Official W3 WebRTC specification](https://www.w3.org/TR/webrtc/)
- [pion/webrtc Package](https://github.com/pion/webrtc)
- [SCTP](https://en.wikipedia.org/wiki/Stream_Control_Transmission_Protocol)
- [DTLS](https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security)
