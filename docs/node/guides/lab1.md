---
sidebar_position: 1
---

# Lab 1: Signal generation

import AsciinemaPlayer from '@site/src/components/AsciinemaPlayer';
import 'asciinema-player/dist/bundle/asciinema-player.css';

<figure align="center">
    <img alt="villas-signal Example" src="/img/drawio/villas_signal.svg" height="180px" />
    <figcaption>villas-signal Example.</figcaption>
</figure>

The first and simplest utility of the VILLASnode toolbox is a signal generator.
Rarely used in a real simulation, this tool can be handy for testing and understanding other commands of VILLASnode.

The following command emits a stream of samples to the [standard output](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29) of your terminal:

```shell
villas signal -l 10 -r 10 -F 3 -v 1 sine
```

The samples have the following characteristics:

| Option	| Description |
| :---	| :--- |
| `-l 10` | Limits the output to 10 samples |
| `-r 10` | Samples the signal with a rate of 10 Hz |
| `-F 3` 	| Sets the frequency of the generated signal to 3 Hz |
| `-v 1` 	| Sets the number of values which are generated |

<AsciinemaPlayer src="/recordings/terminal/villas_signal.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />

Every sample is printed in a single line consisting of several columns:

```
# sec.nsec(seq)          data[]
1493840575.228483413(0)  0.000000
1493834176.992267295(1)  0.945584
1493834177.092542246(2) -0.605785
1493834177.192117703(3) -0.576049
1493834177.292412070(4)  0.957041
1493834177.391855814(5) -0.009495
1493834177.492009272(6) -0.947156
1493834177.592494371(7)  0.605067
1493834177.692448200(8)  0.570946
1493834177.791826929(9) -0.953784
```

The first column is a combination of timestamp and sequence number in the form of `seconds.nanoseconds+offset(sequenceno)`.
The timestamp is derived from Unix time (seconds after 01/01/1970 UTC).
The remaining columns contain the values of the sample.

If you add the `-n` (non real-time mode) switch the data will be printed immediately to the screen:

```shell
villas signal -l 10 -r 10 -F 3 -v 1 -n sine
```

<AsciinemaPlayer src="/recordings/terminal/villas_signal_nrt.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />


You can use [shell redirection](https://www.gnu.org/software/bash/manual/html_node/Redirections.html) to write those samples to a file:

```shell
villas signal -l 10 -r 10 -F 3 -v 1 -n sine > file.dat
cat file.dat
```

<AsciinemaPlayer src="/recordings/terminal/villas_signal_file.json" rows={25} cols={120} idleTimeLimit={3} preload={true} />
