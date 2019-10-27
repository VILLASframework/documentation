# Real-Time Protocol (RTP & RTCP) {#node-type-rtp}

# Prerequisites {#node-prereq-rtp}

This node-type requires [libre](http://www.creytiv.com/re.html) (>= 0.6.0).

# Implementation {#node-implementation-rtp}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/develop/lib/nodes/rtp.c

# Configuration {#node-config-node-rtp}

## netem (dictionary) {#node-config-node-rtp-netem}

Enables and configures the network emulation qeueing discipline.

For more information see also: @ref node-netem

## Example

@include node/etc/examples/nodes/rtp.conf

# Further reading

- https://en.wikipedia.org/wiki/Real-time_Transport_Protocol
- https://www.ietf.org/proceedings/67/slides/avt-1.pdf
- https://csperkins.org/standards/ietf-64/2005-11-10-IETF64-DCCP-rtp-dccp.pdf
- https://tools.ietf.org/html/rfc5762
- https://tools.ietf.org/html/rfc4340
