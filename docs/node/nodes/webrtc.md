---
hide_table_of_contents: false
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

:::info Lab exercise
For a hands-on exercise, please have a look at [Lab 18: WebRTC](../guides/lab18.md).
:::

**See also:** The [WebSocket node-type](./websocket.md) is a related but older node-type.

## Prerequisites

This node-type requires [libdatachannel](https://libdatachannel.org/) > v0.18.4.
We recommend building libdatachannel with [libnice](https://libnice.freedesktop.org/) to support ICE connections via TCP by passing the [`-DUSE_NICE=ON`](https://github.com/paullouisageneau/libdatachannel/blob/1f6f09bbb5457895e422fea2960260b6dbef7192/CMakeLists.txt#L10) to CMake.

### WebRTC Signaling Server
A publicly reachable signaling server is required. [RWTH-ACS](https://www.acs.eonerc.rwth-aachen.de) operates such a signaling server at `https://villas.k8s.eonerc.rwth-aachen.de/ws/signaling` which is used by default.
If two VILLASnode instances are connected, the **name of the `webrtc` node-type must differ** between the configuration files. 

If a local signaling server should be run, the latest docker image can be pulled:
`docker run -p 8080:8080 --privileged registry.git.rwth-aachen.de/acs/public/villas/signaling:server-client-communication`.
The source code is available here: https://github.com/VILLASframework/signaling

## Implementation

The source code of the node-type is available here:
https://github.com/VILLASframework/node/blob/master/go/pkg/nodes/webrtc/

## Limitations

:::note
WebRTC only supports is limited to the bi-directional exchange of data between **two** peers.
Exchanging data between a group of more than two peers is not possible.

Please refer to the `websocket`, `mqtt` or `amqp` node-types for exchanging data between a of nodes using a publish/subscribe message pattern.
:::

## Web Demo {#demo}

:::caution Deprecation
This demo is deprecated. It is currently updated.
:::

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
