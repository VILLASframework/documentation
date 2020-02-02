# OMA Next Generation Services Interface {#node-type-ngsi}

The `ngsi` node type implements an interface to FIWARE context brokers.
Currently version 1 of the RESTful HTTP API is implemented and using NGSI10 for the context management interface.

This implementation if currently limited to the `updateContext` operation.
Therefore only publishing updates is supported. Subscribtion or polling of events is planned for later versions.

# Prerequisites {#node-prereq-ngsi}

This node-type requires to following libraries to communicate with the context broker over JSON:

 - [libjansson](http://www.digip.org/jansson/) (>= 2.7)
 - [libcurl](https://curl.haxx.se/libcurl/) (>= 7.29.0)

# Implementation {#node-implementation-ngsi}

The source code of the node-type is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/nodes/ngsi.c

# Configuration {#node-config-node-ngsi}

You can use the @ref node-config-node-vectorize setting to send multiple samples in a vector.

Every `ngsi` node supports the following special settings:

## endpoint (string: uri) {#node-config-node-ngsi-endpoint}

## entity_id (string) {#node-config-node-ngsi-entity_id}

## entity_type (string) {#node-config-node-ngsi-entity_type}

## ssl_verify (boolean) {#node-config-node-ngsi-ssl_verify}

## timeout (float: seconds) {#node-config-node-ngsi-timeout}

## mapping (array of strings) {#node-config-node-ngsi-mapping}

Example: `AttributeName(AttributeType) MetadataName1(MetadataType1)=MetadataValue1 MetadataName2(MetadataType2)=MetadataValue2 ...`

## Example

@include node/etc/examples/nodes/ngsi.conf

# Further reading

This standard was specified by the Open Mobile Alliance (OMA).

@see https://forge.fiware.org/plugins/mediawiki/wiki/fiware/index.php/FI-WARE_NGSI-10_Open_RESTful_API_Specification
@see http://technical.openmobilealliance.org/Technical/Release_Program/docs/NGSI/V1_0-20120529-A/OMA-TS-NGSI_Context_Management-V1_0-20120529-A.pdf
