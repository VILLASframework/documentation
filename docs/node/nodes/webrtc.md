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

This node-type requires [libdatachannel](https://libdatachannel.org/) > v0.18.4.
We recommend building libdatachannel with [libnice](https://libnice.freedesktop.org/) to support ICE connections via TCP by passing the [`-DUSE_NICE=ON`](https://github.com/paullouisageneau/libdatachannel/blob/1f6f09bbb5457895e422fea2960260b6dbef7192/CMakeLists.txt#L10) to CMake.

A publicly reachable signaling server is required.
[RWTH-ACS](https://www.acs.eonerc.rwth-aachen.de) operates such a signaling server at `wss://villas.k8s.eonerc.rwth-aachen.de/ws/signaling` which is used by default.

You can use your own signaling server by using the code here: https://github.com/VILLASframework/signaling

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/go/pkg/nodes/webrtc/

## Web Demo {#demo}

There exists an example WebRTC peer implementation running in a web-browser:

- **Source:** https://github.com/VILLASframework/node/blob/master/web/webrtc.html
- **Online Demo:** https://villas.fein-aachen.org/webrtc/

## Configuration {#config}

import ApiSchema from '@theme/ApiSchema';

<ApiSchema id="node" example pointer="#/components/schemas/webrtc" />

## Example

``` url="external/node/etc/examples/nodes/webrtc.conf" title="node/etc/examples/nodes/webrtc.conf"
nodes = {
	webrtc_node = {
		type = "webrtc",

		format = "json"

		# A unique session identifier which must be shared between two nodes
		session = "my-session-name"

		# Address to the websocket signaling server
		server = "https://villas.k8s.eonerc.rwth-aachen.de/ws/signaling"

		# Limit the number of times a channel will retransmit data if not successfully delivered.
        	# This value may be clamped if it exceeds the maximum value supported.
		max_retransmits = 0

		# Number of seconds to wait for a WebRTC connection before proceeding the start
		# of VILLASnode. Mainly used for testing
		wait_seconds = 10 # in seconds

		# Indicates if data is allowed to be delivered out of order.
        	# The default value of false, does not make guarantees that data will be delivered in order.
		ordered = false

		# Setting for Interactive Connectivity Establishment
		ice = {
			# List of STUN/TURN servers
			servers = (
				"stun:stun.0l.de:3478",
				"turn:villas:villas@turn.0l.de:3478?transport=udp",
				"turn:villas:villas@turn.0l.de:3478?transport=tcp"
			)
		}
	}
}
```

## Further reading

- [Official W3 WebRTC specification](https://www.w3.org/TR/webrtc/)
- [libdatachannel](https://libdatachannel.org/)
- [SCTP](https://en.wikipedia.org/wiki/Stream_Control_Transmission_Protocol)
- [DTLS](https://en.wikipedia.org/wiki/Datagram_Transport_Layer_Security)
