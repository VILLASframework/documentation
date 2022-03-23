#!/bin/bash

PREFIX=villas

TOOLS=$(compgen -c | egrep "^${PREFIX}-" | sort -u)

for TOOL in ${TOOLS}; do
    ${TOOL} -h | sed 's/\x1b\[[0-9;]*m//g' > ${TOOL}.txt
done
