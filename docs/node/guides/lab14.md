---
sidebar_position: 14
---

# Lab 14: File comparison

One of the important uses of the VILLASnode toolbox is the comparison of a list of files.

The following command can be used to compare the files:

```bash
villas-test-cmp [OPTIONS] FILE1 FILE2 ... FILEn
```

Where options refers to one or more of the following: 

| Option  | Description                                         |
| :---	  | :---                                                |
| -d LVL  | Adjust the debug level                              |
| -e EPS  | Set epsilon for floating point comparisons to EPS   |
| -v      | Ignore data values                                  |
| -T      | Ignore timestamp                                    |
| -s      | Ignore sequence no                                  |
| -F fmt  | File format for all files                           |
| -t DT   | The data-type format string                         |
| -h      | show this usage information                         |
| -V      | show the version of the tool                        |

In this example we shall use this tool to compare two files. In the first terminal execute the following command: 

```bash
villas signal sine > file_send.dat
villas pipe lab3.conf villas_node1 < file_send.dat
```

Open a second terminal to record the data being sent into another file. Execute the following command: 

```bash
villas pipe -x lab3.conf villas_node1 > file_receive.dat
```

Now run the following command to compare the two files. He we ignore the timestamps since it will be different in both the cases:

```bash
villas test-cmp -T file_send.dat file_receive.dat
```

Following return codes are obtained based on the similarity between the two files:

| Code | Description |
|:--   |:-- |
| 0    | files are equal  |
| 1    | file length not equal |
| 2    | sequence no not equal |
| 3    | timestamp not equal |
| 4    | number of values is not equal |
| 5    | data is not equal |
  
Following command can be used to determine the return codes:

```bash
echo $?
```

Since the files are equal in this example we get 0 as the return code. 
