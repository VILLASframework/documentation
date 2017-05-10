# Lab 10: The daemon {#node-guide-lab10}

During the previous labs, we use the `villas pipe`, `villas hook` and `villas signal` tools connect simulators and process the exchanged simulation data. This approach is handy for small tests, development and training.
However, more complex scenaries are unmanagable with this approach.

In this lab we introduce the VILLASnode daemon `villas node` which provides an easier way to setup complex scenarios.
In addition, `villas node` benefits from lower latencies because we omit the standard input / output streams and the conversion of the samples in a human readable / line-based representation.

**Note:** We recommend the usage of the daemon for all critical HIL simulations

The invocation of the daemon os pretty simple.
Just pass the path to the configuration file as a paramteter:

```bash
$ villas node lab10_path_uni.conf
```

All VILLASnode tools can fetch their configuration file from remote locations (all [protocols from libcurl](https://curl.haxx.se/libcurl/c/CURLOPT_PROTOCOLS.html) are supported):

```bash
# From a web server
$ villas node https://villas.fein-aachen.org/doc/etc/lab3.conf

# From a Windows share (use single quotes!)
$ villas node 'smb://domain\user:passwd@example.com/share/file.conf'

# From a FTP server
$ villas node ftp://user:passwd@example.com/lab3.conf'

# Via SSH / SFTP
$ villas node sftp://user:passwd@example.com/etc/villas/node/lab3.conf
```

## Example configurations

`lab10_nodes.conf`:

@includelineno lab10_nodes.conf Nodes for the following examples.

## A unidirectional path

The configuration file `lab10_uni_path.conf` extends `lab3.conf` with a path section:

@includelineno lab10_path_uni.conf

## A path with multiple destinations

@includelineno lab10_path_multiple_destinations.conf

## A path with a hook

@includelineno lab10_path_hook.conf

## A bidirectional path

@includelineno lab10_path_bidir.conf