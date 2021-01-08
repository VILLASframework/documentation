#!/bin/bash

PATH=$PATH:/usr/share/nginx/cgi-bin/
PREFIX="/doc"
ANCHOR=${QUERY_STRING}

QUERY_STRING="n=1&q=${ANCHOR}"

URL=$(doxysearch.cgi | \
	tail -n +3 | tail -c +2 | head -c -2 | \
	jq --raw-output	'if .hits >= 1 then .items[0].url else "" end'
)

if [ -n "${URL}" ]; then
	LOCATION="${PREFIX}/${URL}#${ANCHOR}"
else
	LOCATION="${PREFIX}/search.html?query=${ANCHOR}"
fi

echo "Location: ${LOCATION}"
echo
