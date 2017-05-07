# Lab 10: The daemon  {#node-guide-lab10}

During the previous labs, we use the `villas pipe`, `villas hook` and `villas signal` tools connect simulators and process the exchanged simulation data.
This approach is handy for small tests, development and training.
However, more complex scenaries are unmanagable with this approach.

In this lab we introduce the VILLASnode daemon `villas node` which provides an easier way to setup complex scenarios.
In addition, `villas node` benefits from lower latencies because we omit the standard input / output streams and the conversion of the samples in a human readable / line-based representation.

**Note:** We recommend `villas node` for all critical HIL simulations.

`lab10.conf`:

@includelineno lab10.conf

To start the deamon run the following command:

```bash
$ villas node lab10.conf
```