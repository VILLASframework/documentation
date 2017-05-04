# Paths {#node-concept-path}

A path is a **uni-directional** connection between incoming and outgoing nodes.

It forwards messages from a single incoming node to multiple outgoing nodes.
Therefore it represents a 1-to-n relation between nodes.

For bidirectional communication a corresponding path in the reverse direction must be added.
 
By default, message contents are not altered.
The server only performs checks for valid message headers (sequence number, cryptographic signature..).
However every path supports optional hook/callback functions which allow user-defined operations on the message contents.

@diafile path_simple.dia

@see path for implementation details.