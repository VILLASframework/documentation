# File {#node-type-file}

The @ref node-type-file node-type can be used to log or replay samples to / from disk.

# Prerequisites {#node-prereq-file}

This node-type does not have any special library dependencies. It is always available.

# Implementation {#node-implementation-file}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/develop/lib/nodes/file.c

# Configuration {#node-config-node-file}

Every `file` node can be configured to only read or write or to do both at the same time.
The node configuration is divided into two sub-groups: `in` and `out`.

## uri (string: uri) {#node-config-node-file-uri}

Specifies the URI to a file from which is written to or read from depending in which group (`in`or `out`) is used.

This setting allows to add special paceholders for time and date values.
See [strftime(3)](http://man7.org/linux/man-pages/man3/strftime.3.html) for a list of supported placeholder.

**Example**:

```
uri = "logs/measurements_%Y-%m-%d_%H-%M-%S.log"
```

will create a file called:

```
./logs/measurements_2015-08-09_22-20-50.log
```

## format (string: format-id) = "villas.human" {#node-config-node-file-format}

A IO format identifier selecting the file format which is used for reading and writing from the file.

See @ref node-formats for a complete list of supported formats.

## mode (string: "a" | "w" | "a+" | "w+" | "r") {#node-config-node-file-mode}

Specifies the mode which should be used to open the output file.
See [open(2)](http://man7.org/linux/man-pages/man2/open.2.html) for an explanation of allowed values.
The default value is `w+` which will start writing at the beginning of the file and create it in case it does not exist yet.

## in.epoch (float) {#node-config-node-file-epoch}

## in.epoch_mode ("direct" | "wait" | "relative" | "absolute") {#node-config-node-file-in-epoch_mode}

The *epoch* describes the point in time when the first message will be read from the file.
This setting allows to select the behaviour of the following `epoch` setting.
It can be used to adjust the point in time when the first value should be read.

The behaviour of `epoch` is depending on the value of `epoch_mode`.

To facilitate the following description of supported `epoch_mode`'s, we will introduce some intermediate variables (timestamps).
Those variables will also been displayed during the startup phase of the server to simplify debugging.

- `epoch` is the value of the `epoch` setting.
- `first` is the timestamp of the first message / line in the input file.
- `offset` will be added to the timestamps in the file to obtain the real time when the message will be sent.
- `start` is the point in time when the first message will be sent (`first + offset`).
- `eta` the time to wait until the first message will be send (`start - now`)

The supported values for `epoch_mode`:

| `epoch_mode` 	| `offset` 		| `start = first + offset` |
| :--		| :--			| :-- |
| `direct`  	| `now - first + epoch` 	| `now + epoch` |
| `wait`  	| `now + epoch` 		| `now + first` |
| `relative` 	| `epoch` 		| `first + epoch` |
| `absolute` 	| `epoch - first` 	| `epoch` |
| `original` 	| `0` 			| immeadiatly |

## in.rate (float) {#node-config-node-file-in-rate}

By default `send_rate` has the value `0` which means that the time between consecutive samples is the same as in the `in` file based on the timestamps in the first column.

If this setting has a non-zero value, the default behaviour is overwritten with a fixed rate.

## in.eof (string: "rewind" | "exit" | "wait") = "exit" {#node-config-node-file-in-eof}

Defines the behaviour if the end of file of the input file is reached.

 - `rewind` will rewind the file pointer and restart reading samples from the beginning of the file.
 - `exit` will terminated the program.
 - `wait` will periodically test if there are new samples which have been appended to the file.

## in.buffer_size (unsigned) = 0 {#node-config-node-file-in-buffer_size}

Similar to @ref node-config-node-file-out-buffer_size. This means that the data is loaded into the buffer before it is passed on to the node.

If `in.buffer_size = 0`, no buffer will be generated.

## out.flush (boolean) {#node-config-node-file-out-flush}

With this setting enabled, the outgoing file is flushed whenever new samples have been written to it.
For remote files this means that the new sample is appended to the remote file which involves network IO.

**Note:** Not all network file protocols might support partial uploads.
It's know that this feature works for local files but not for WebDav.
Other protocols hav not been tested yet.

## out.buffer_size (unsigned) = 0 {#node-config-node-file-out-buffer_size}

If this is set to a positive value `<X>`, the node will generate a full [stream buffer](https://linux.die.net/man/3/setvbuf) with a size of `<X>` bytes. This means that the data is buffered and not written until the buffer is full or until the node is stopped.

If `out.buffer_size = 0`, no buffer will be generated.

## Example

### Using local files
@include node/etc/examples/nodes/file.conf

### Using remote files
@include node/etc/examples/nodes/advio.conf
