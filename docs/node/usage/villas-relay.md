# villas relay

The `villas relay` command starts a WebSocket server which relays messages between connected clients.
Based on the URL which clients use for their connection, seperate sessions can be opened.
The relay does not require configuration.

# Usage

``` url="generated/node/usage/villas-relay.txt" title="generated/node/usage/villas-relay.txt"
Usage: villas-relay [OPTIONS]
  OPTIONS is one or more of the following options:
    -d LVL    set debug level
    -p PORT   the port number to listen on
    -P PROT   the websocket protocol
    -l        enable loopback of own data
    -u UUID   unique instance id
    -V        show version and exit
    -h        show usage and exit

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>```
