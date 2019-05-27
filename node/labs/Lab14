# Lab 14: File comparison 

VILLASnode toolbox can be used for the comparison of a list of files

The following command can be used to compare a list of files:

```
$ villas-test-cmp [OPTIONS] FILE1 FILE2 ... FILEn
```
where options refers to one of the following: 

| Option	| Description |
| :---	| :--- |
| -d LVL | Adjust the debug level |
| -e EPS | Set epsilon for floating point comparisons to EPS |
| -v | Ignore data values |
| -T | Ignore timestamp |
| -s | Ignore sequence no |
| -F fmt | File format for all files |
| -t DT | The data-type format string |
| -h | show this usage information |
| -V | show the version of the tool |

In this example we shall use this tool to compare two files. In the first terminal execute the following command: 
```
$ villas signal sine > file_send.dat
$ villas pipe lab3.conf villas_node1 < file_send.dat
```
Open a second terminal to record the data being sent into another file. Execute the following command: 

```
$ villas pipe -x lab3.conf villas_node1 > file_receive.dat
```
Now run the following command to compare the two files. He we ignore the timestamps since it will be different in both the cases:

```
$ villas test-cmp -T file_send.dat file_receive.dat
```

Following result is obtained based on the similarity between the two files:

```
Return codes:
  0   files are equal
  1   file length not equal
  2   sequence no not equal
  3   timestamp not equal
  4   number of values is not equal
  5   data is not equal
```
  
Following command can be used to determine the return codes:

```
echo $?
```
Since the files are equal in this example we get 0 as the return code. 