# Lab 4: Receive data from a node and show it on standard output  {#node-guide-lab4}

@image html villas_pipe2.svg height=150px

Similarily, _samples_ which are send to the node are printed on the screen.
To demonstrate this we start `villas pipe` a second time with swapped `local` and `remote` addresses.

In the first terminal:
```
$ villas pipe lab3.conf udp_node1
```

@htmlonly
<asciinema-player rows="25" cols="500" poster="npt:0:1"  src="recordings/lab4_t2.json">
@endhtmlonly

In a second terminal, we append `-x` to swap the addresses:
```
$ villas pipe lab3.conf udp_node1 -x
```

@htmlonly
<asciinema-player rows="25" cols="500" poster="npt:0:1"  src="recordings/lab4_t1.json">
@endhtmlonly