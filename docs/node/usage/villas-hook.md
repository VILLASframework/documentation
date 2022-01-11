---
sidebar_position: 4
---

# villas hook

The `villas hook` command can be used to test filter / process hook functions.

# Usage

``` url="generated/node/usage/villas-hook.txt" title="generated/node/usage/villas-hook.txt"
Usage: villas-hook [OPTIONS] NAME
  NAME      the name of the hook function
  PARAM*    a string of configuration settings for the hook
  OPTIONS is one or more of the following options:
    -f FMT  the data format
    -t DT   the data-type format string
    -d LVL  set debug level to LVL
    -v CNT  process CNT smps at once
    -o PARAM=VALUE  provide parameters for hook configuration
    -h      show this help
    -V      show the version of the tool

Supported hooks:
 - average: Calculate average over some signals
 - cast: Cast signals types
 - decimate: Downsamping by integer factor
 - dft: This hook calculates the  dft on a window
 - dp: Transform to/from dynamic phasor domain
 - drop: Drop messages with reordered sequence numbers
 - dump: Dump data to stdout
 - ebm: Energy-based Metric
 - fix: Fix received data by adding missing fields
 - gate: Skip samples only if an enable signal is under a specified threshold
 - jitter_calc: Calc jitter, mean and variance of GPS vs NTP TS
 - limit_rate: Limit sending rate
 - average: Calculate average over some signals
 - restart: Call restart hooks for current node
 - scale: Scale signals by a factor and add offset
 - shift_seq: Shift sequence number of samples
 - shift_ts: Shift timestamps of samples
 - skip_first: Skip the first samples
 - stats: Collect statistics for the current path
 - ts: Overwrite origin timestamp of samples with receive timestamp
 - pps_ts: Timestamp samples based GPS PPS signal
 - print: Print the message to stdout
 - lua: Implement hook in Lua

Supported IO formats:
 - json         : Javascript Object Notation
 - iotagent_ul  : FIWARE IotAgent UltraLight format
 - json.reserve : RESERVE JSON format
 - villas.binary: VILLAS binary network format
 - villas.web   : VILLAS binary network format for WebSockets
 - villas.human : VILLAS human readable format
 - tsv          : Tabulator-separated values
 - csv          : Comma-separated values
 - raw.8        : Raw  8 bit
 - raw.16.be    : Raw 16 bit, big endian byte-order
 - raw.32.be    : Raw 32 bit, big endian byte-order
 - raw.64.be    : Raw 64 bit, big endian byte-order
 - raw.16.le    : Raw 16 bit, little endian byte-order
 - raw.32.le    : Raw 32 bit, little endian byte-order
 - raw.64.le    : Raw 64 bit, little endian byte-order
 - gtnet        : RTDS GTNET
 - gtnet.fake   : RTDS GTNET with fake header
 - value        : A bare text value without any headers

Example:
  villas-signal random | villas-hook skip_first seconds=10

 v0.11.0-5c666fb-debug (built on Feb 23 2021 02:34:46)
 Copyright 2014-2017, Institute for Automation of Complex Power Systems, EONERC
 Steffen Vogel <StVogel@eonerc.rwth-aachen.de>
```
