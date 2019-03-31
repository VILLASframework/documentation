#!/bin/bash

TOOLS = villas \
    villas-node \
    villas-pipe \
    villas-signal \
    villas-hook \
    villas-relay \
    villas-test-cmp \
    villas-test-rtt \
    villas-test-config

for TOOL in ${TOOLS}; do
    ${TOOL} -h > ${TOOL}.txt
done
