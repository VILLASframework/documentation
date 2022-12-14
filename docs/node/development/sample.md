# Sample {#node-dev-sample}

One of the main design decisions while developing VILLASnode gateway was the choice of a simple and common data structure for simulation data.

In VILLAS terminology, we refer to this as a _sample_. A sample is a set of signals which have been generated, simulated or measured at the same sampling time instant. Each node-type needs to convert its own data format into the common intermediate data structure.
This enables VILLASnode to interface each of the available [node-types](../nodes/index.md) with each other.

Some node-types have support for different data formats. E.g. the [`mqtt`](../nodes/mqtt.md) node-type can transport its payloads in varying formats.
Available pluggable (de-)serializers documented at: [Format-types](../formats/index.md).

## Data Structure

The data-structure used by VILLASnode is defined by the [`struct Sample`](https://github.com/VILLASframework/node/blob/master/include/villas/sample.hpp).

### Sequence Number

Each sample contains a sequence number. This sequence number needs to increase monotonically.
The main purpose of the sequence number is the detection of lost, reordered or duplicated samples.

### Timestamps

Each sample contains a timestamps which define the sample instant.
Timestamps are stored as `struct timespec` which contain an UNIX timestamp (seconds after 1.1.1970, UTC) as well as the nanoseconds of the current seconds. Both fields are stored as 32 Bit integers.

### Data

In order to ease implementation of new node-types, the data structure is kept as simple as possible:
Each sample stores its signal data as a linear array of values:

```c
union SignalData {
    double f;			            /**< Floating point values. */
    int64_t i;			            /**< Integer values. */
    bool b;				            /**< Boolean values. */
    float _Complex z;	            /**< Complex values. */
};

struct Sample {
    uint64_t sequence;			    /**< The sequence number of this sample. */
    unsigned length;			    /**< The number of values in sample::values which are valid. */
    unsigned capacity;			    /**< The number of values in sample::values for which memory is reserved. */
    int flags;                      /**< Flags are used to store binary properties of a sample. */

    SignalList::Ptr signals;	    /**< The list of signal descriptors. */

    std::atomic<int> refcnt;	    /**< Reference counter. */
    ptrdiff_t pool_off;			    /**< This sample belongs to this memory pool (relative pointer). See sample_pool(). */

    /** All timestamps are seconds / nano seconds after 1.1.1970 UTC */
    struct {
        struct timespec origin;		/**< The point in time when this data was sampled. */
        struct timespec received;	/**< The point in time when this data was received. */
    } ts;

    // Variable length array at the end of the struct
    union SignalData data[];
};
```

Metadata such as signal names, units, data-types etc. which dot not change between samples are not part of `struct sample`.
They are rather stored in a separate list of `struct signal` definitions.
The design of VILLASnode assumes that the these signal definitions remain static over the runtime of VILLASnode,

Each sample contains a pointer to this list of signal definitions.
The indices of signal data corresponds to the index within the list of signal definitions.
