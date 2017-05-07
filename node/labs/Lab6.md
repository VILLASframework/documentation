# Lab 6: Write received sample data to a file {#node-guide-lab6}

@image html villas_pipe_file.svg

Receive data from node `udp_node1` and save to file `file.dat`:

```
$ villas pipe lab3.conf udp_node1 > file.dat
```

@htmlonly
<asciinema-player rows="25" cols="500" poster="npt:0:13"  src="recordings/lab6.json">
@endhtmlonly