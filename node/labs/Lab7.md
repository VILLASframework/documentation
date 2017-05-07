# Lab 7: Read samples from file and send them to node  {#node-guide-lab7}

@image html villas_pipe_file2.svg Send and receive samples from files to simulator height=320px

```bash
$ villas pipe lab3.conf udp_node1 < file_send.dat > file_recv.dat
```

**Note:** In this lab all samples of `file.dat` will be sent immediately to `udp_node1`.
Usually, this is not the desired behaviour.
We will show later how to stream the samples _in real-time_ to a destination node.

## Better way

In order to stream the samples in real-time from a file, we will use the @ref node-type-file node-type with the following configuration file (`lab7.conf`):

@includelineno lab7.conf

@image html villas_pipe_file3.svg Stream samples in real-time from file height=340px

```bash
$ villas pipe lab7.conf file_node1 | villas pipe lab3.conf udp_node1 > file_recv.dat
```