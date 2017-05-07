# Lab 9: Use a hook function to collect statistics {#node-guide-lab9}

```bash
$ villas signal sine -r 1000 -l 10000 | villas hook stats verbose=true warmup=3000
```


## With network emulation


@includelineno lab9_netem.conf

In  the first terminal:

```bash
$ villas signal sine -r 1000 -l 10000 | villas pipe etc/lab9_netem.conf udp_node1
```


In a second terminal:

```bash
villas pipe etc/lab9_netem.conf udp_node1 -x | villas hook stats verbose=true warmup=3000
```

**Note:** Press Ctrl-D to stop the statistics colleciton.