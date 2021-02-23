# Paths {#node-concept-path}

A path is a **uni-directional** connection between incoming and outgoing nodes.

It forwards messages from one or more incoming nodes to one or more outgoing nodes.
Therefore it represents a n-to-n relation between nodes.

For bidirectional communication a corresponding path in the reverse direction must be added.
 
By default, message contents are not altered.
The server only performs checks for valid message headers (sequence number, cryptographic signature..).
However, every path supports optional  @ref node-concept-hook functions which allow user-defined operations on the @ref node-concept-sample contents.

@image html VILLASnode_paths.svg

