#!/bin/bash

PREFIX=villas

TOOLS=$(compgen -c | egrep "^${PREFIX}-" | sort -u)

for TOOL in ${TOOLS}; do
    ${TOOL} -h > ${TOOL}.txt
done
